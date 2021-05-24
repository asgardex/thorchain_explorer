// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tc_node_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TCNodeVersion _$TCNodeVersionFromJson(Map<String, dynamic> json) {
  return TCNodeVersion(
    current: json['current'] as String,
    next: json['next'] as String,
  );
}

Map<String, dynamic> _$TCNodeVersionToJson(TCNodeVersion instance) =>
    <String, dynamic>{
      'current': instance.current,
      'next': instance.next,
    };
