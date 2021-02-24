import 'package:json_annotation/json_annotation.dart';

part 'tc_network.g.dart';

@JsonSerializable()
class BondMetricsStat {
  int averageBond;
  int maximumBond;
  int medianBond;
  int minimumBond;
  int totalBond;

  BondMetricsStat();

  factory BondMetricsStat.fromJson(Map<String, dynamic> json) =>
      _$BondMetricsStatFromJson(json);
}

@JsonSerializable()
class BondMetrics {
  BondMetricsStat active;
  BondMetricsStat standby;

  BondMetrics();

  factory BondMetrics.fromJson(Map<String, dynamic> json) =>
      _$BondMetricsFromJson(json);
}

@JsonSerializable()
class BlockRewards {
  int blockReward;
  int bondReward;
  int poolReward;

  BlockRewards();

  factory BlockRewards.fromJson(Map<String, dynamic> json) =>
      _$BlockRewardsFromJson(json);
}

@JsonSerializable()
class TCNetwork {
  TCNetwork();

  double bondingAPY;
  List<int> activeBonds;
  int activeNodeCount;
  BondMetrics bondMetrics;
  BlockRewards blockRewards;
  double liquidityAPY;
  int nextChurnHeight;
  int poolActivationCountdown;
  double poolShareFactor;
  int totalReserve;
  List<int> standbyBonds;
  int standbyNodeCount;
  int totalPooledRune;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory TCNetwork.fromJson(Map<String, dynamic> json) =>
      _$TCNetworkFromJson(json);
}
