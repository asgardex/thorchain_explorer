// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stats _$StatsFromJson(Map<String, dynamic> json) {
  return Stats()
    ..addLiquidityCount = json['addLiquidityCount'] as String
    ..addLiquidityVolume = json['addLiquidityVolume'] as String
    ..dailyActiveUsers = json['dailyActiveUsers'] as String
    ..impermanentLossProtectionPaid =
        json['impermanentLossProtectionPaid'] as String
    ..monthlyActiveUsers = json['monthlyActiveUsers'] as String
    ..runeDepth = json['runeDepth'] as String
    ..runePriceUSD = json['runePriceUSD'] as String
    ..swapCount = json['swapCount'] as String
    ..swapCount24h = json['swapCount24h'] as String
    ..swapCount30d = json['swapCount30d'] as String
    ..swapVolume = json['swapVolume'] as String
    ..switchedRune = json['switchedRune'] as String
    ..toAssetCount = json['toAssetCount'] as String
    ..toRuneCount = json['toRuneCount'] as String
    ..uniqueSwapperCount = json['uniqueSwapperCount'] as String
    ..withdrawCount = json['withdrawCount'] as String
    ..withdrawVolume = json['withdrawVolume'] as String;
}

Map<String, dynamic> _$StatsToJson(Stats instance) => <String, dynamic>{
      'addLiquidityCount': instance.addLiquidityCount,
      'addLiquidityVolume': instance.addLiquidityVolume,
      'dailyActiveUsers': instance.dailyActiveUsers,
      'impermanentLossProtectionPaid': instance.impermanentLossProtectionPaid,
      'monthlyActiveUsers': instance.monthlyActiveUsers,
      'runeDepth': instance.runeDepth,
      'runePriceUSD': instance.runePriceUSD,
      'swapCount': instance.swapCount,
      'swapCount24h': instance.swapCount24h,
      'swapCount30d': instance.swapCount30d,
      'swapVolume': instance.swapVolume,
      'switchedRune': instance.switchedRune,
      'toAssetCount': instance.toAssetCount,
      'toRuneCount': instance.toRuneCount,
      'uniqueSwapperCount': instance.uniqueSwapperCount,
      'withdrawCount': instance.withdrawCount,
      'withdrawVolume': instance.withdrawVolume,
    };
