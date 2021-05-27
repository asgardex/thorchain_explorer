// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pool_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoolStats _$PoolStatsFromJson(Map<String, dynamic> json) {
  return PoolStats()
    ..asset = json['asset'] as String
    ..status = json['status'] as String
    ..assetPrice = json['assetPrice'] as String
    ..assetPriceUSD = json['assetPriceUSD'] as String
    ..assetDepth = json['assetDepth'] as String
    ..runeDepth = json['runeDepth'] as String
    ..units = json['units'] as String
    ..toAssetVolume = json['toAssetVolume'] as String
    ..toRuneVolume = json['toRuneVolume'] as String
    ..swapVolume = json['swapVolume'] as String
    ..toAssetCount = json['toAssetCount'] as String
    ..toRuneCount = json['toRuneCount'] as String
    ..swapCount = json['swapCount'] as String
    ..uniqueSwapperCount = json['uniqueSwapperCount'] as String
    ..toAssetAverageSlip = json['toAssetAverageSlip'] as String
    ..toRuneAverageSlip = json['toRuneAverageSlip'] as String
    ..averageSlip = json['averageSlip'] as String
    ..toAssetFees = json['toAssetFees'] as String
    ..toRuneFees = json['toRuneFees'] as String
    ..totalFees = json['totalFees'] as String
    ..poolAPY = json['poolAPY'] as String
    ..addAssetLiquidityVolume = json['addAssetLiquidityVolume'] as String
    ..addRuneLiquidityVolume = json['addRuneLiquidityVolume'] as String
    ..addLiquidityVolume = json['addLiquidityVolume'] as String
    ..addLiquidityCount = json['addLiquidityCount'] as String
    ..withdrawAssetVolume = json['withdrawAssetVolume'] as String
    ..withdrawRuneVolume = json['withdrawRuneVolume'] as String
    ..impermanentLossProtectionPaid =
        json['impermanentLossProtectionPaid'] as String
    ..withdrawVolume = json['withdrawVolume'] as String
    ..withdrawCount = json['withdrawCount'] as String
    ..uniqueMemberCount = json['uniqueMemberCount'] as String;
}

Map<String, dynamic> _$PoolStatsToJson(PoolStats instance) => <String, dynamic>{
      'asset': instance.asset,
      'status': instance.status,
      'assetPrice': instance.assetPrice,
      'assetPriceUSD': instance.assetPriceUSD,
      'assetDepth': instance.assetDepth,
      'runeDepth': instance.runeDepth,
      'units': instance.units,
      'toAssetVolume': instance.toAssetVolume,
      'toRuneVolume': instance.toRuneVolume,
      'swapVolume': instance.swapVolume,
      'toAssetCount': instance.toAssetCount,
      'toRuneCount': instance.toRuneCount,
      'swapCount': instance.swapCount,
      'uniqueSwapperCount': instance.uniqueSwapperCount,
      'toAssetAverageSlip': instance.toAssetAverageSlip,
      'toRuneAverageSlip': instance.toRuneAverageSlip,
      'averageSlip': instance.averageSlip,
      'toAssetFees': instance.toAssetFees,
      'toRuneFees': instance.toRuneFees,
      'totalFees': instance.totalFees,
      'poolAPY': instance.poolAPY,
      'addAssetLiquidityVolume': instance.addAssetLiquidityVolume,
      'addRuneLiquidityVolume': instance.addRuneLiquidityVolume,
      'addLiquidityVolume': instance.addLiquidityVolume,
      'addLiquidityCount': instance.addLiquidityCount,
      'withdrawAssetVolume': instance.withdrawAssetVolume,
      'withdrawRuneVolume': instance.withdrawRuneVolume,
      'impermanentLossProtectionPaid': instance.impermanentLossProtectionPaid,
      'withdrawVolume': instance.withdrawVolume,
      'withdrawCount': instance.withdrawCount,
      'uniqueMemberCount': instance.uniqueMemberCount,
    };
