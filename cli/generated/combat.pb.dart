///
//  Generated code. Do not modify.
//  source: combat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'combat.pbenum.dart';

export 'combat.pbenum.dart';

class PlayerAction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PlayerAction', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerId')
    ..e<PlayerAction_ActionType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'action', $pb.PbFieldType.OE, defaultOrMaker: PlayerAction_ActionType.START, valueOf: PlayerAction_ActionType.valueOf, enumValues: PlayerAction_ActionType.values)
    ..hasRequiredFields = false
  ;

  PlayerAction._() : super();
  factory PlayerAction({
    $core.String? playerId,
    PlayerAction_ActionType? action,
  }) {
    final _result = create();
    if (playerId != null) {
      _result.playerId = playerId;
    }
    if (action != null) {
      _result.action = action;
    }
    return _result;
  }
  factory PlayerAction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerAction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerAction clone() => PlayerAction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerAction copyWith(void Function(PlayerAction) updates) => super.copyWith((message) => updates(message as PlayerAction)) as PlayerAction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlayerAction create() => PlayerAction._();
  PlayerAction createEmptyInstance() => create();
  static $pb.PbList<PlayerAction> createRepeated() => $pb.PbList<PlayerAction>();
  @$core.pragma('dart2js:noInline')
  static PlayerAction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerAction>(create);
  static PlayerAction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get playerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set playerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayerId() => clearField(1);

  @$pb.TagNumber(2)
  PlayerAction_ActionType get action => $_getN(1);
  @$pb.TagNumber(2)
  set action(PlayerAction_ActionType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => clearField(2);
}

class CombatState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CombatState', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'titanId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'titanHp', $pb.PbFieldType.O3)
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerId')
    ..hasRequiredFields = false
  ;

  CombatState._() : super();
  factory CombatState({
    $core.String? titanId,
    $core.int? titanHp,
    $core.Iterable<$core.String>? playerId,
  }) {
    final _result = create();
    if (titanId != null) {
      _result.titanId = titanId;
    }
    if (titanHp != null) {
      _result.titanHp = titanHp;
    }
    if (playerId != null) {
      _result.playerId.addAll(playerId);
    }
    return _result;
  }
  factory CombatState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CombatState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CombatState clone() => CombatState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CombatState copyWith(void Function(CombatState) updates) => super.copyWith((message) => updates(message as CombatState)) as CombatState; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CombatState create() => CombatState._();
  CombatState createEmptyInstance() => create();
  static $pb.PbList<CombatState> createRepeated() => $pb.PbList<CombatState>();
  @$core.pragma('dart2js:noInline')
  static CombatState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CombatState>(create);
  static CombatState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get titanId => $_getSZ(0);
  @$pb.TagNumber(1)
  set titanId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitanId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get titanHp => $_getIZ(1);
  @$pb.TagNumber(2)
  set titanHp($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitanHp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitanHp() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get playerId => $_getList(2);
}

