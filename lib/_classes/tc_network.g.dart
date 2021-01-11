// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tc_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TCNetwork _$TCNetworkFromJson(Map<String, dynamic> json) {
  return TCNetwork()
    ..activeBonds =
        (json['activeBonds'] as List)?.map((e) => e as int)?.toList()
    ..activeNodeCount = json['activeNodeCount'] as int
    ..bondingAPY = (json['bondingAPY'] as num)?.toDouble()
    ..liquidityAPY = (json['liquidityAPY'] as num)?.toDouble()
    ..nextChurnHeight = json['nextChurnHeight'] as int
    ..poolActivationCountdown = json['poolActivationCountdown'] as int
    ..poolShareFactor = (json['poolShareFactor'] as num)?.toDouble()
    ..totalReserve = json['totalReserve'] as int
    ..standbyBonds =
        (json['standbyBonds'] as List)?.map((e) => e as int)?.toList()
    ..standbyNodeCount = json['standbyNodeCount'] as int
    ..totalPooledRune = json['totalPooledRune'] as int;
}

Map<String, dynamic> _$TCNetworkToJson(TCNetwork instance) => <String, dynamic>{
      'activeBonds': instance.activeBonds,
      'activeNodeCount': instance.activeNodeCount,
      'bondingAPY': instance.bondingAPY,
      'liquidityAPY': instance.liquidityAPY,
      'nextChurnHeight': instance.nextChurnHeight,
      'poolActivationCountdown': instance.poolActivationCountdown,
      'poolShareFactor': instance.poolShareFactor,
      'totalReserve': instance.totalReserve,
      'standbyBonds': instance.standbyBonds,
      'standbyNodeCount': instance.standbyNodeCount,
      'totalPooledRune': instance.totalPooledRune,
    };
