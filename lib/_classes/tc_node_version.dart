import 'package:json_annotation/json_annotation.dart';

part 'tc_node_version.g.dart';

@JsonSerializable()
class TCNodeVersion {
  TCNodeVersion({this.current = '', this.next = ''});

  String current;
  String next;

  factory TCNodeVersion.fromJson(Map<String, dynamic> json) =>
      _$TCNodeVersionFromJson(json);
}
