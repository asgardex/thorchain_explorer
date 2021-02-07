// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tc_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PubKeySet _$PubKeySetFromJson(Map<String, dynamic> json) {
  return PubKeySet()
    ..secp256k1 = json['secp256k1'] as String
    ..ed25519 = json['ed25519'] as String;
}

Map<String, dynamic> _$PubKeySetToJson(PubKeySet instance) => <String, dynamic>{
      'secp256k1': instance.secp256k1,
      'ed25519': instance.ed25519,
    };

TCNodeJail _$TCNodeJailFromJson(Map<String, dynamic> json) {
  return TCNodeJail()
    ..nodeAddress = json['node_address'] as String
    ..releaseHeight = json['release_height'] as int
    ..reason = json['reason'] as String;
}

Map<String, dynamic> _$TCNodeJailToJson(TCNodeJail instance) =>
    <String, dynamic>{
      'node_address': instance.nodeAddress,
      'release_height': instance.releaseHeight,
      'reason': instance.reason,
    };

ObservedChain _$ObservedChainFromJson(Map<String, dynamic> json) {
  return ObservedChain()
    ..chain = json['chain'] as String
    ..height = json['height'] as int;
}

Map<String, dynamic> _$ObservedChainToJson(ObservedChain instance) =>
    <String, dynamic>{
      'chain': instance.chain,
      'height': instance.height,
    };

PreflightStatus _$PreflightStatusFromJson(Map<String, dynamic> json) {
  return PreflightStatus()
    ..status = json['status'] as String
    ..reason = json['reason'] as String
    ..code = json['code'] as int;
}

Map<String, dynamic> _$PreflightStatusToJson(PreflightStatus instance) =>
    <String, dynamic>{
      'status': instance.status,
      'reason': instance.reason,
      'code': instance.code,
    };

TCNode _$TCNodeFromJson(Map<String, dynamic> json) {
  return TCNode()
    ..nodeAddress = json['node_address'] as String
    ..status = _$enumDecodeNullable(_$TCNodeStatusEnumMap, json['status'])
    ..pubKeySet = json['pub_key_set'] == null
        ? null
        : PubKeySet.fromJson(json['pub_key_set'] as Map<String, dynamic>)
    ..validatorConsPubKey = json['validator_cons_pub_key'] as String
    ..bond = json['bond'] as String
    ..activeBlockHeight = json['active_block_height'] as int
    ..bondAddress = json['bond_address'] as String
    ..statusSince = json['status_since'] as int
    ..signerMembership =
        (json['signer_membership'] as List)?.map((e) => e as String)?.toList()
    ..requestedToLeave = json['requested_to_leave'] as bool
    ..forcedToLeave = json['forced_to_leave'] as bool
    ..leaveHeight = json['leave_height'] as int
    ..ipAddress = json['ip_address'] as String
    ..version = json['version'] as String
    ..slashPoints = json['slash_points'] as int
    ..jail = json['jail'] == null
        ? null
        : TCNodeJail.fromJson(json['jail'] as Map<String, dynamic>)
    ..currentAward = json['current_award'] as String
    ..observedChains = (json['observe_chains'] as List)
        ?.map((e) => e == null
            ? null
            : ObservedChain.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..preflightStatus = json['preflight_status'] == null
        ? null
        : PreflightStatus.fromJson(
            json['preflight_status'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TCNodeToJson(TCNode instance) => <String, dynamic>{
      'node_address': instance.nodeAddress,
      'status': _$TCNodeStatusEnumMap[instance.status],
      'pub_key_set': instance.pubKeySet,
      'validator_cons_pub_key': instance.validatorConsPubKey,
      'bond': instance.bond,
      'active_block_height': instance.activeBlockHeight,
      'bond_address': instance.bondAddress,
      'status_since': instance.statusSince,
      'signer_membership': instance.signerMembership,
      'requested_to_leave': instance.requestedToLeave,
      'forced_to_leave': instance.forcedToLeave,
      'leave_height': instance.leaveHeight,
      'ip_address': instance.ipAddress,
      'version': instance.version,
      'slash_points': instance.slashPoints,
      'jail': instance.jail,
      'current_award': instance.currentAward,
      'observe_chains': instance.observedChains,
      'preflight_status': instance.preflightStatus,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TCNodeStatusEnumMap = {
  TCNodeStatus.ACTIVE: 'Active',
  TCNodeStatus.STANDBY: 'Standby',
  TCNodeStatus.DISABLED: 'Disabled',
  TCNodeStatus.WHITELISTED: 'Whitelisted',
};
