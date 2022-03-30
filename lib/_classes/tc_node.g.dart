// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tc_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PubKeySet _$PubKeySetFromJson(Map<String, dynamic> json) {
  return PubKeySet(
    secp256k1: json['secp256k1'] as String,
    ed25519: json['ed25519'] as String,
  );
}

Map<String, dynamic> _$PubKeySetToJson(PubKeySet instance) => <String, dynamic>{
      'secp256k1': instance.secp256k1,
      'ed25519': instance.ed25519,
    };

TCNodeJail _$TCNodeJailFromJson(Map<String, dynamic> json) {
  return TCNodeJail()
    ..nodeAddr = json['nodeAddr'] as String?
    ..releaseHeight = json['releaseHeight'] as int
    ..reason = json['reason'] as String?;
}

Map<String, dynamic> _$TCNodeJailToJson(TCNodeJail instance) =>
    <String, dynamic>{
      'nodeAddr': instance.nodeAddr,
      'releaseHeight': instance.releaseHeight,
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
    ..reason = json['reason'] as String?
    ..code = json['code'] as int;
}

Map<String, dynamic> _$PreflightStatusToJson(PreflightStatus instance) =>
    <String, dynamic>{
      'status': instance.status,
      'reason': instance.reason,
      'code': instance.code,
    };

TCNode _$TCNodeFromJson(Map<String, dynamic> json) {
  return TCNode(
    status: _$enumDecode(_$TCNodeStatusEnumMap, json['status']),
    publicKeys: json['publicKeys'] == null
        ? null
        : PubKeySet.fromJson(json['publicKeys'] as Map<String, dynamic>),
  )
    ..address = json['address'] as String
    ..bond = json['bond'] as int
    ..requestedToLeave = json['requestedToLeave'] as bool?
    ..forcedToLeave = json['forcedToLeave'] as bool?
    ..leaveHeight = json['leaveHeight'] as int?
    ..ipAddress = json['ipAddress'] as String
    ..version = json['version'] as String
    ..slashPoints = json['slashPoints'] as int
    ..jail = json['jail'] == null
        ? null
        : TCNodeJail.fromJson(json['jail'] as Map<String, dynamic>)
    ..currentAward = json['currentAward'] as int;
}

Map<String, dynamic> _$TCNodeToJson(TCNode instance) => <String, dynamic>{
      'address': instance.address,
      'status': _$TCNodeStatusEnumMap[instance.status],
      'publicKeys': instance.publicKeys,
      'bond': instance.bond,
      'requestedToLeave': instance.requestedToLeave,
      'forcedToLeave': instance.forcedToLeave,
      'leaveHeight': instance.leaveHeight,
      'ipAddress': instance.ipAddress,
      'version': instance.version,
      'slashPoints': instance.slashPoints,
      'jail': instance.jail,
      'currentAward': instance.currentAward,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$TCNodeStatusEnumMap = {
  TCNodeStatus.ACTIVE: 'Active',
  TCNodeStatus.READY: 'Ready',
  TCNodeStatus.STANDBY: 'Standby',
  TCNodeStatus.DISABLED: 'Disabled',
  TCNodeStatus.WHITELISTED: 'Whitelisted',
  TCNodeStatus.UNKNOWN: 'Unknown',
};
