import 'package:json_annotation/json_annotation.dart';

part 'tc_network.g.dart';

@JsonSerializable()
class BondMetricsStat {
  int? averageBond = 0;
  int? maximumBond = 0;
  int? medianBond = 0;
  int? minimumBond = 0;
  int? totalBond = 0;

  BondMetricsStat();

  factory BondMetricsStat.fromJson(Map<String, dynamic> json) =>
      _$BondMetricsStatFromJson(json);
}

@JsonSerializable()
class BondMetrics {
  BondMetricsStat? active;
  BondMetricsStat? standby;

  BondMetrics({required this.active, required this.standby});

  factory BondMetrics.fromJson(Map<String, dynamic> json) =>
      _$BondMetricsFromJson(json);
}

@JsonSerializable()
class BlockRewards {
  int? blockReward = 0;
  int? bondReward = 0;
  int? poolReward = 0;

  BlockRewards();

  factory BlockRewards.fromJson(Map<String, dynamic> json) =>
      _$BlockRewardsFromJson(json);
}

@JsonSerializable()
class TCNetwork {
  TCNetwork();

  double? bondingAPY = 0;
  List<int>? activeBonds = [];
  int? activeNodeCount = 0;
  BondMetrics? bondMetrics;
  BlockRewards? blockRewards;
  double? liquidityAPY = 0;
  int? nextChurnHeight = 0;
  int? poolActivationCountdown = 0;
  double? poolShareFactor = 0;
  int? totalReserve = 0;
  List<int>? standbyBonds = [];
  int? standbyNodeCount = 0;
  int? totalPooledRune = 0;

  factory TCNetwork.fromJson(Map<String, dynamic> json) =>
      _$TCNetworkFromJson(json);
}
