// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stats _$StatsFromJson(Map<String, dynamic> json) {
  return Stats()
    ..dailyActiveUsers = json['dailyActiveUsers'] as int
    ..dailyTx = json['dailyTx'] as int
    ..monthlyActiveUsers = json['monthlyActiveUsers'] as int
    ..monthlyTx = json['monthlyTx'] as int
    ..totalAssetBuys = json['totalAssetBuys'] as int
    ..totalAssetSells = json['totalAssetSells'] as int
    ..totalDepth = json['totalDepth'] as int
    ..totalStakeTx = json['totalStakeTx'] as int
    ..totalStaked = json['totalStaked'] as int
    ..totalTx = json['totalTx'] as int
    ..totalUsers = json['totalUsers'] as int
    ..totalVolume = json['totalVolume'] as int
    ..totalWithdrawTx = json['totalWithdrawTx'] as int;
}

Map<String, dynamic> _$StatsToJson(Stats instance) => <String, dynamic>{
      'dailyActiveUsers': instance.dailyActiveUsers,
      'dailyTx': instance.dailyTx,
      'monthlyActiveUsers': instance.monthlyActiveUsers,
      'monthlyTx': instance.monthlyTx,
      'totalAssetBuys': instance.totalAssetBuys,
      'totalAssetSells': instance.totalAssetSells,
      'totalDepth': instance.totalDepth,
      'totalStakeTx': instance.totalStakeTx,
      'totalStaked': instance.totalStaked,
      'totalTx': instance.totalTx,
      'totalUsers': instance.totalUsers,
      'totalVolume': instance.totalVolume,
      'totalWithdrawTx': instance.totalWithdrawTx,
    };
