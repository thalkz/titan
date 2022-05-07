///
//  Generated code. Do not modify.
//  source: combat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'combat.pb.dart' as $0;
export 'combat.pb.dart';

class CombatClient extends $grpc.Client {
  static final _$fight = $grpc.ClientMethod<$0.PlayerAction, $0.CombatState>(
      '/Combat/Fight',
      ($0.PlayerAction value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CombatState.fromBuffer(value));

  CombatClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.CombatState> fight(
      $async.Stream<$0.PlayerAction> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$fight, request, options: options);
  }
}

abstract class CombatServiceBase extends $grpc.Service {
  $core.String get $name => 'Combat';

  CombatServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PlayerAction, $0.CombatState>(
        'Fight',
        fight,
        true,
        true,
        ($core.List<$core.int> value) => $0.PlayerAction.fromBuffer(value),
        ($0.CombatState value) => value.writeToBuffer()));
  }

  $async.Stream<$0.CombatState> fight(
      $grpc.ServiceCall call, $async.Stream<$0.PlayerAction> request);
}
