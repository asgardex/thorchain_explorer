import 'package:json_annotation/json_annotation.dart';

part 'node_location.g.dart';

@JsonSerializable()
class NodeLocation {
  String ip = '';
  String? city = '-';
  String? region = '-';
  String? country = '-';
  String? loc = '-';
  String? org = '-';
  String? postal = '';
  String? timezone = '';

  NodeLocation();

  factory NodeLocation.fromJson(Map<String, dynamic> json) =>
      _$NodeLocationFromJson(json);

  Map<String, dynamic> toJson() => _$NodeLocationToJson(this);
}
