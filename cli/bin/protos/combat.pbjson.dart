///
//  Generated code. Do not modify.
//  source: combat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use playerActionDescriptor instead')
const PlayerAction$json = const {
  '1': 'PlayerAction',
  '2': const [
    const {'1': 'player_id', '3': 1, '4': 1, '5': 9, '10': 'playerId'},
    const {'1': 'action', '3': 2, '4': 1, '5': 14, '6': '.PlayerAction.ActionType', '10': 'action'},
  ],
  '4': const [PlayerAction_ActionType$json],
};

@$core.Deprecated('Use playerActionDescriptor instead')
const PlayerAction_ActionType$json = const {
  '1': 'ActionType',
  '2': const [
    const {'1': 'START', '2': 0},
    const {'1': 'LEAVE', '2': 1},
    const {'1': 'ATTACK', '2': 2},
  ],
};

/// Descriptor for `PlayerAction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerActionDescriptor = $convert.base64Decode('CgxQbGF5ZXJBY3Rpb24SGwoJcGxheWVyX2lkGAEgASgJUghwbGF5ZXJJZBIwCgZhY3Rpb24YAiABKA4yGC5QbGF5ZXJBY3Rpb24uQWN0aW9uVHlwZVIGYWN0aW9uIi4KCkFjdGlvblR5cGUSCQoFU1RBUlQQABIJCgVMRUFWRRABEgoKBkFUVEFDSxAC');
@$core.Deprecated('Use combatStateDescriptor instead')
const CombatState$json = const {
  '1': 'CombatState',
  '2': const [
    const {'1': 'titan_id', '3': 1, '4': 1, '5': 9, '10': 'titanId'},
    const {'1': 'titan_hp', '3': 2, '4': 1, '5': 5, '10': 'titanHp'},
    const {'1': 'player_ids', '3': 3, '4': 3, '5': 9, '10': 'playerIds'},
    const {'1': 'player_count', '3': 4, '4': 1, '5': 5, '10': 'playerCount'},
  ],
};

/// Descriptor for `CombatState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List combatStateDescriptor = $convert.base64Decode('CgtDb21iYXRTdGF0ZRIZCgh0aXRhbl9pZBgBIAEoCVIHdGl0YW5JZBIZCgh0aXRhbl9ocBgCIAEoBVIHdGl0YW5IcBIdCgpwbGF5ZXJfaWRzGAMgAygJUglwbGF5ZXJJZHMSIQoMcGxheWVyX2NvdW50GAQgASgFUgtwbGF5ZXJDb3VudA==');
