///
//  Generated code. Do not modify.
//  source: combat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class PlayerAction_ActionType extends $pb.ProtobufEnum {
  static const PlayerAction_ActionType START = PlayerAction_ActionType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'START');
  static const PlayerAction_ActionType LEAVE = PlayerAction_ActionType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEAVE');
  static const PlayerAction_ActionType ATTACK = PlayerAction_ActionType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ATTACK');

  static const $core.List<PlayerAction_ActionType> values = <PlayerAction_ActionType> [
    START,
    LEAVE,
    ATTACK,
  ];

  static final $core.Map<$core.int, PlayerAction_ActionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PlayerAction_ActionType? valueOf($core.int value) => _byValue[value];

  const PlayerAction_ActionType._($core.int v, $core.String n) : super(v, n);
}

