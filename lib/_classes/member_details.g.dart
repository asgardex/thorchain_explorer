// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDetails _$MemberDetailsFromJson(Map<String, dynamic> json) {
  return MemberDetails()
    ..pools = (json['pools'] as List<dynamic>)
        .map((e) => MemberPool.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MemberDetailsToJson(MemberDetails instance) =>
    <String, dynamic>{
      'pools': instance.pools,
    };

MemberPool _$MemberPoolFromJson(Map<String, dynamic> json) {
  return MemberPool()
    ..pool = json['pool'] as String
    ..runeAddress = json['runeAddress'] as String?
    ..assetAddress = json['assetAddress'] as String?
    ..liquidityUnits = json['liquidityUnits'] as String
    ..runeAdded = json['runeAdded'] as String
    ..assetAdded = json['assetAdded'] as String
    ..runeWithdrawn = json['runeWithdrawn'] as String
    ..assetWithdrawn = json['assetWithdrawn'] as String
    ..dateFirstAdded = json['dateFirstAdded'] as String
    ..dateLastAdded = json['dateLastAdded'] as String;
}

Map<String, dynamic> _$MemberPoolToJson(MemberPool instance) =>
    <String, dynamic>{
      'pool': instance.pool,
      'runeAddress': instance.runeAddress,
      'assetAddress': instance.assetAddress,
      'liquidityUnits': instance.liquidityUnits,
      'runeAdded': instance.runeAdded,
      'assetAdded': instance.assetAdded,
      'runeWithdrawn': instance.runeWithdrawn,
      'assetWithdrawn': instance.assetWithdrawn,
      'dateFirstAdded': instance.dateFirstAdded,
      'dateLastAdded': instance.dateLastAdded,
    };
