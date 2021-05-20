// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pool_volume_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeStats _$VolumeStatsFromJson(Map<String, dynamic> json) {
  return VolumeStats(
    count: json['count'] as int?,
    volumeInAsset: json['volumeInAsset'] as int?,
    volumeInRune: json['volumeInRune'] as int?,
  );
}

Map<String, dynamic> _$VolumeStatsToJson(VolumeStats instance) =>
    <String, dynamic>{
      'count': instance.count,
      'volumeInRune': instance.volumeInRune,
      'volumeInAsset': instance.volumeInAsset,
    };

PoolVolumeHistoryMeta _$PoolVolumeHistoryMetaFromJson(
    Map<String, dynamic> json) {
  return PoolVolumeHistoryMeta(
    first: json['first'] as int?,
    last: json['last'] as int?,
    combined: VolumeStats.fromJson(json['combined'] as Map<String, dynamic>),
    toRune: VolumeStats.fromJson(json['toRune'] as Map<String, dynamic>),
    toAsset: VolumeStats.fromJson(json['toAsset'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PoolVolumeHistoryMetaToJson(
        PoolVolumeHistoryMeta instance) =>
    <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'combined': instance.combined,
      'toRune': instance.toRune,
      'toAsset': instance.toAsset,
    };

PoolVolumeHistoryBucket _$PoolVolumeHistoryBucketFromJson(
    Map<String, dynamic> json) {
  return PoolVolumeHistoryBucket(
    time: json['time'] as int,
    combined: VolumeStats.fromJson(json['combined'] as Map<String, dynamic>),
    toRune: VolumeStats.fromJson(json['toRune'] as Map<String, dynamic>),
    toAsset: VolumeStats.fromJson(json['toAsset'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PoolVolumeHistoryBucketToJson(
        PoolVolumeHistoryBucket instance) =>
    <String, dynamic>{
      'time': instance.time,
      'combined': instance.combined,
      'toRune': instance.toRune,
      'toAsset': instance.toAsset,
    };

PoolVolumeHistory _$PoolVolumeHistoryFromJson(Map<String, dynamic> json) {
  return PoolVolumeHistory(
    meta: PoolVolumeHistoryMeta.fromJson(json['meta'] as Map<String, dynamic>),
    intervals: (json['intervals'] as List<dynamic>)
        .map((e) => PoolVolumeHistoryBucket.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PoolVolumeHistoryToJson(PoolVolumeHistory instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'intervals': instance.intervals,
    };
