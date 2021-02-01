import 'package:json_annotation/json_annotation.dart';

part 'pool.g.dart';

@JsonSerializable()
class PoolStakes {

  PoolStakes();

  int assetStaked;
  int runeStaked;
  int poolStaked;

  factory PoolStakes.fromJson(Map<String, dynamic> json) => _$PoolStakesFromJson(json);
}

@JsonSerializable()
class PoolDepth {

  PoolDepth();

  int assetDepth;
  int runeDepth;
  int poolDepth;

  factory PoolDepth.fromJson(Map<String, dynamic> json) => _$PoolDepthFromJson(json);
}

@JsonSerializable()
class Pool {

  Pool();

  String asset;
  String status;
  double price;
  int units;
  PoolStakes stakes;
  PoolDepth depth;
  int volume24h;
  double poolAPY;

  factory Pool.fromJson(Map<String, dynamic> json) => _$PoolFromJson(json);
}
