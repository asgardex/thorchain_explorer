// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoolStakes _$PoolStakesFromJson(Map<String, dynamic> json) {
  return PoolStakes()
    ..assetStaked = json['assetStaked'] as int
    ..runeStaked = json['runeStaked'] as int
    ..poolStaked = json['poolStaked'] as int;
}

Map<String, dynamic> _$PoolStakesToJson(PoolStakes instance) =>
    <String, dynamic>{
      'assetStaked': instance.assetStaked,
      'runeStaked': instance.runeStaked,
      'poolStaked': instance.poolStaked,
    };

PoolDepth _$PoolDepthFromJson(Map<String, dynamic> json) {
  return PoolDepth()
    ..assetDepth = json['assetDepth'] as int
    ..runeDepth = json['runeDepth'] as int
    ..poolDepth = json['poolDepth'] as int;
}

Map<String, dynamic> _$PoolDepthToJson(PoolDepth instance) => <String, dynamic>{
      'assetDepth': instance.assetDepth,
      'runeDepth': instance.runeDepth,
      'poolDepth': instance.poolDepth,
    };

Pool _$PoolFromJson(Map<String, dynamic> json) {
  return Pool()
    ..asset = json['asset'] as String
    ..status = json['status'] as String
    ..price = (json['price'] as num)?.toDouble()
    ..units = json['units'] as int
    ..stakes = json['stakes'] == null
        ? null
        : PoolStakes.fromJson(json['stakes'] as Map<String, dynamic>)
    ..depth = json['depth'] == null
        ? null
        : PoolDepth.fromJson(json['depth'] as Map<String, dynamic>)
    ..volume24h = json['volume24h'] as int
    ..poolAPY = (json['poolAPY'] as num)?.toDouble();
}

Map<String, dynamic> _$PoolToJson(Pool instance) => <String, dynamic>{
      'asset': instance.asset,
      'status': instance.status,
      'price': instance.price,
      'units': instance.units,
      'stakes': instance.stakes,
      'depth': instance.depth,
      'volume24h': instance.volume24h,
      'poolAPY': instance.poolAPY,
    };
