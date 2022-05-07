import 'dart:math';

import 'package:grpc/grpc.dart';

import '../generated/combat.pbgrpc.dart';

void main(List<String> args) async {
  final channel = ClientChannel(
    "localhost",
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );
  final combatStub = CombatClient(channel);

  int userCount = int.tryParse(args[0]) ?? 1;
  int actionsCount = int.tryParse(args[1]) ?? 1;

  try {
    await Future.wait(List.generate(userCount, (index) => _fight(combatStub, actionsCount)));
  } catch (error) {
    print('Server error: $error');
  }
  await channel.shutdown();
}

PlayerAction_ActionType _getAction(int index, int count) {
  if (index == 0) {
    return PlayerAction_ActionType.START;
  } else if (index == count - 1) {
    return PlayerAction_ActionType.LEAVE;
  } else {
    return PlayerAction_ActionType.ATTACK;
  }
}

Stream<PlayerAction> generateActions(String playerId, int count) async* {
  for (int i = 0; i < count; i++) {
    yield PlayerAction(
      action: _getAction(i, count),
      playerId: playerId,
    );
    final rnd = Random().nextInt(1000);
    await Future.delayed(Duration(milliseconds: rnd));
  }
}

Future<void> _fight(CombatClient stub, int actionsCount) async {
  final rnd = Random().nextInt(10000);
  String playerId = "player#$rnd";
  final actions = generateActions(playerId, actionsCount + 2);
   final combatStates = stub.fight(actions, options: CallOptions(timeout: Duration(seconds: 30)));
  int maxConnectedPlayers = 0;
  await for (final state in combatStates) {
    maxConnectedPlayers = max(maxConnectedPlayers, state.playerCount);
    // print("connected: ${state.playerCount}, max: $maxConnectedPlayers (${state.titanId} ${state.titanHp}hp)");
  }
}
