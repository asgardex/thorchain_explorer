import 'package:json_annotation/json_annotation.dart';

part 'stats.g.dart';

@JsonSerializable()
class Stats {
  Stats();

  int dailyActiveUsers;
  int dailyTx;
  int monthlyActiveUsers;
  int monthlyTx;
  int totalAssetBuys;
  int totalAssetSells;
  int totalDepth;
  int totalStakeTx;
  int totalStaked;
  int totalTx;
  int totalUsers;
  int totalVolume;
  int totalWithdrawTx;

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
}
