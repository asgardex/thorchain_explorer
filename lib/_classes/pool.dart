import 'package:json_annotation/json_annotation.dart';

part 'pool.g.dart';

@JsonSerializable()
class PoolStakes {
  PoolStakes(
      {required this.assetStaked,
      required this.runeStaked,
      required this.poolStaked});

  int assetStaked;
  int runeStaked;
  int poolStaked;

  factory PoolStakes.fromJson(Map<String, dynamic> json) =>
      _$PoolStakesFromJson(json);
}

@JsonSerializable()
class PoolDepth {
  PoolDepth(
      {required this.assetDepth,
      required this.runeDepth,
      required this.poolDepth});

  int assetDepth;
  int runeDepth;
  int poolDepth;

  factory PoolDepth.fromJson(Map<String, dynamic> json) =>
      _$PoolDepthFromJson(json);
}

@JsonSerializable()
class Pool {
  Pool(
      {required this.asset,
      required this.status,
      required this.price,
      this.units,
      this.stakes,
      this.depth,
      required this.volume24h,
      required this.poolAPY});

  String asset;
  String status;
  double price;
  int? units;
  PoolStakes? stakes;
  PoolDepth? depth;
  int volume24h;
  double poolAPY;

  factory Pool.fromJson(Map<String, dynamic> json) => _$PoolFromJson(json);
}
