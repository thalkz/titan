import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

import '../../protos/combat.pbgrpc.dart';

class CombatView extends StatefulWidget {
  const CombatView({Key? key, required this.playerId}) : super(key: key);

  static const routeName = '/combat';
  final String playerId;

  @override
  State<CombatView> createState() => _CombatViewState();
}

class _CombatViewState extends State<CombatView> {
  final StreamController<PlayerAction> actionsController = StreamController();
  late final StreamSubscription subscription;
  late final ClientChannel channel;
  CombatState _combatState = CombatState();

  @override
  void initState() {
    super.initState();
    channel = ClientChannel(
      "localhost",
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    final stub = CombatClient(channel);

    final combatStates = stub.fight(actionsController.stream);
    subscription = combatStates.listen((combatState) {
      if (mounted) {
        setState(() {
          _combatState = combatState;
        });
      }
    });

    actionsController.add(PlayerAction(playerId: widget.playerId, action: PlayerAction_ActionType.START));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_combatState.titanId),
            Text('hp = ${_combatState.titanHp}'),
            Text('connected players = ${_combatState.playerCount}'),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () => actionsController.add(
                      PlayerAction(
                        playerId: widget.playerId,
                        action: PlayerAction_ActionType.ATTACK,
                      ),
                    ),
                child: const Text("Attack"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    actionsController.add(PlayerAction(playerId: widget.playerId, action: PlayerAction_ActionType.LEAVE));
    subscription.cancel();
    await actionsController.close();
    await channel.shutdown();
  }
}
