import 'package:json_annotation/json_annotation.dart';

part 'tc_network.g.dart';

@JsonSerializable()
class TCNetwork {
  TCNetwork();

  List<int> activeBonds;
  int activeNodeCount;
  // BondMetrics bondMetrics;
  // BlockRewards blockRewards;
  double bondingAPY;
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
