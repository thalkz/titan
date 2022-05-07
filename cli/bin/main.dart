import 'dart:math';

import 'package:grpc/grpc.dart';

import '../generated/combat.pbgrpc.dart';
import '../generated/greeter.pbgrpc.dart';

void main(List<String> arguments) async {
  final channel = ClientChannel("localhost",
      port: 50051, options: const ChannelOptions(credentials: ChannelCredentials.insecure()));
  final greeterStub = GreeterClient(channel);
  final combatStub = CombatClient(channel);

  // try {
  //   await _listenServerMonologue(stub);
  // } catch (error) {
  //   print('Server monologue error: $error');
  // }

  // try {
  //   await _sendClientMonologue(stub);
  // } catch (error) {
  //   print('Server monologue error: $error');
  // }

  // try {
  //   await Future.wait(
  //     List.generate(10000, (index) => _makeConversation(stub))
  //   );
  // } catch (error) {
  //   print('Server monologue error: $error');
  // }

  try {
    await _fightTitan(combatStub);
  } catch (error) {
    print('Server monologue error: $error');
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
    await Future.delayed(Duration(seconds: 1));
  }
}

Future<void> _fightTitan(CombatClient stub) async {
  final rnd = Random().nextInt(10000);
  String playerId = "player#$rnd";

  final actions = generateActions(playerId, 20);
  final combatStates = stub.fight(actions);
  await for (final state in combatStates) {
    print('Combat state: $state');
  }
}

Stream<HelloRequest> generateRequests(int count) async* {
  for (int i = 0; i < count; i++) {
    final request = HelloRequest(name: "Request #$i");
    await Future.delayed(Duration(seconds: 1));
    yield request;
  }
}

Future<void> _makeConversation(GreeterClient stub) async {
  final requestStream = generateRequests(10);
  final responseStream = stub.conversation(requestStream);
  await for (final response in responseStream) {
    print('Got message ${response.message}');
  }
}

Future<void> _sendClientMonologue(GreeterClient stub) async {
  final stream =
      Stream<HelloRequest>.periodic(Duration(seconds: 1), (index) => HelloRequest(name: "player$index")).take(5);

  final reply = await stub.clientMonologue(stream, options: CallOptions(timeout: Duration(seconds: 60)));
  print("Reply: $reply");
}

Future<void> _listenServerMonologue(GreeterClient stub) {
  final request = HelloRequest(name: "Thalkz");
  var subscription = stub.serverMonologue(request).listen((event) {
    print('Response: $event');
  });
  return subscription.asFuture();
}
