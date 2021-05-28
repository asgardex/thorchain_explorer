import 'package:json_annotation/json_annotation.dart';

part 'stats.g.dart';

@JsonSerializable()
class Stats {
  Stats();

  String addLiquidityCount = '';
  String addLiquidityVolume = '';
  String dailyActiveUsers = '';
  String impermanentLossProtectionPaid = '';
  String monthlyActiveUsers = '';
  String runeDepth = '';
  String runePriceUSD = '';
  String swapCount = '';
  String swapCount24h = '';
  String swapCount30d = '';
  String swapVolume = '';
  String switchedRune = '';
  String toAssetCount = '';
  String toRuneCount = '';
  String uniqueSwapperCount = '';
  String withdrawCount = '';
  String withdrawVolume = '';

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
}
