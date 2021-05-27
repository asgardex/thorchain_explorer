import 'package:json_annotation/json_annotation.dart';

part 'pool_stats.g.dart';

@JsonSerializable()
class PoolStats {
  String asset = '';
  String status = '';
  String assetPrice = '';
  String assetPriceUSD = '';
  String assetDepth = '';
  String runeDepth = '';
  String units = '';
  String toAssetVolume = '';
  String toRuneVolume = '';
  String swapVolume = '';
  String toAssetCount = '';
  String toRuneCount = '';
  String swapCount = '';
  String uniqueSwapperCount = '';
  String toAssetAverageSlip = '';
  String toRuneAverageSlip = '';
  String averageSlip = '';
  String toAssetFees = '';
  String toRuneFees = '';
  String totalFees = '';
  String poolAPY = '';
  String addAssetLiquidityVolume = '';
  String addRuneLiquidityVolume = '';
  String addLiquidityVolume = '';
  String addLiquidityCount = '';
  String withdrawAssetVolume = '';
  String withdrawRuneVolume = '';
  String impermanentLossProtectionPaid = '';
  String withdrawVolume = '';
  String withdrawCount = '';
  String uniqueMemberCount = '';

  PoolStats();

  factory PoolStats.fromJson(Map<String, dynamic> json) =>
      _$PoolStatsFromJson(json);
}
