// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tc_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BondMetricsStat _$BondMetricsStatFromJson(Map<String, dynamic> json) {
  return BondMetricsStat()
    ..averageBond = json['averageBond'] as int
    ..maximumBond = json['maximumBond'] as int
    ..medianBond = json['medianBond'] as int
    ..minimumBond = json['minimumBond'] as int
    ..totalBond = json['totalBond'] as int;
}

Map<String, dynamic> _$BondMetricsStatToJson(BondMetricsStat instance) =>
    <String, dynamic>{
      'averageBond': instance.averageBond,
      'maximumBond': instance.maximumBond,
      'medianBond': instance.medianBond,
      'minimumBond': instance.minimumBond,
      'totalBond': instance.totalBond,
    };

BondMetrics _$BondMetricsFromJson(Map<String, dynamic> json) {
  return BondMetrics()
    ..active = json['active'] == null
        ? null
        : BondMetricsStat.fromJson(json['active'] as Map<String, dynamic>)
    ..standby = json['standby'] == null
        ? null
        : BondMetricsStat.fromJson(json['standby'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BondMetricsToJson(BondMetrics instance) =>
    <String, dynamic>{
      'active': instance.active,
      'standby': instance.standby,
    };

BlockRewards _$BlockRewardsFromJson(Map<String, dynamic> json) {
  return BlockRewards()
    ..blockReward = json['blockReward'] as int
    ..bondReward = json['bondReward'] as int
    ..poolReward = json['poolReward'] as int;
}

Map<String, dynamic> _$BlockRewardsToJson(BlockRewards instance) =>
    <String, dynamic>{
      'blockReward': instance.blockReward,
      'bondReward': instance.bondReward,
      'poolReward': instance.poolReward,
    };

TCNetwork _$TCNetworkFromJson(Map<String, dynamic> json) {
  return TCNetwork()
    ..bondingAPY = (json['bondingAPY'] as num)?.toDouble()
    ..activeBonds =
        (json['activeBonds'] as List)?.map((e) => e as int)?.toList()
    ..activeNodeCount = json['activeNodeCount'] as int
    ..bondMetrics = json['bondMetrics'] == null
        ? null
        : BondMetrics.fromJson(json['bondMetrics'] as Map<String, dynamic>)
    ..blockRewards = json['blockRewards'] == null
        ? null
        : BlockRewards.fromJson(json['blockRewards'] as Map<String, dynamic>)
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
      'bondingAPY': instance.bondingAPY,
      'activeBonds': instance.activeBonds,
      'activeNodeCount': instance.activeNodeCount,
      'bondMetrics': instance.bondMetrics,
      'blockRewards': instance.blockRewards,
      'liquidityAPY': instance.liquidityAPY,
      'nextChurnHeight': instance.nextChurnHeight,
      'poolActivationCountdown': instance.poolActivationCountdown,
      'poolShareFactor': instance.poolShareFactor,
      'totalReserve': instance.totalReserve,
      'standbyBonds': instance.standbyBonds,
      'standbyNodeCount': instance.standbyNodeCount,
      'totalPooledRune': instance.totalPooledRune,
    };
