import 'package:json_annotation/json_annotation.dart';

part 'pool_volume_history.g.dart';

@JsonSerializable()
class VolumeStats {
  VolumeStats({this.count = 0, this.volumeInAsset = 0, this.volumeInRune = 0});

  int? count;
  int? volumeInRune;
  int? volumeInAsset;

  factory VolumeStats.fromJson(Map<String, dynamic> json) =>
      _$VolumeStatsFromJson(json);
}

@JsonSerializable()
class PoolVolumeHistoryMeta {
  PoolVolumeHistoryMeta(
      {this.first,
      this.last,
      required this.combined,
      required this.toRune,
      required this.toAsset});

  int? first;
  int? last;
  VolumeStats combined;
  VolumeStats toRune;
  VolumeStats toAsset;

  factory PoolVolumeHistoryMeta.fromJson(Map<String, dynamic> json) =>
      _$PoolVolumeHistoryMetaFromJson(json);
}

@JsonSerializable()
class PoolVolumeHistoryBucket {
  PoolVolumeHistoryBucket(
      {required this.time,
      required this.combined,
      required this.toRune,
      required this.toAsset});

  int time;
  VolumeStats combined;
  VolumeStats toRune;
  VolumeStats toAsset;

  factory PoolVolumeHistoryBucket.fromJson(Map<String, dynamic> json) =>
      _$PoolVolumeHistoryBucketFromJson(json);
}

@JsonSerializable()
class PoolVolumeHistory {
  PoolVolumeHistory({required this.meta, required this.intervals});

  PoolVolumeHistoryMeta meta;
  List<PoolVolumeHistoryBucket> intervals;

  factory PoolVolumeHistory.fromJson(Map<String, dynamic> json) =>
      _$PoolVolumeHistoryFromJson(json);
}
