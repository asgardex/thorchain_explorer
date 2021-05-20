import 'package:json_annotation/json_annotation.dart';

part 'stats.g.dart';

@JsonSerializable()
class Stats {
  Stats();

  int dailyActiveUsers = 0;
  int dailyTx = 0;
  int monthlyActiveUsers = 0;
  int monthlyTx = 0;
  int totalAssetBuys = 0;
  int totalAssetSells = 0;
  int totalDepth = 0;
  int totalStakeTx = 0;
  int totalStaked = 0;
  int totalTx = 0;
  int totalUsers = 0;
  int totalVolume = 0;
  int totalWithdrawTx = 0;

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
}
