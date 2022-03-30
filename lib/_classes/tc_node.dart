import 'package:json_annotation/json_annotation.dart';

part 'tc_node.g.dart';

@JsonSerializable()
class PubKeySet {
  String secp256k1;
  String ed25519;

  PubKeySet({required this.secp256k1, required this.ed25519});
  factory PubKeySet.fromJson(Map<String, dynamic> json) =>
      _$PubKeySetFromJson(json);
}

@JsonSerializable()
class TCNodeJail {
  String? nodeAddr = '';
  int releaseHeight = 0;
  String? reason = '';
  TCNodeJail();

  factory TCNodeJail.fromJson(Map<String, dynamic> json) =>
      _$TCNodeJailFromJson(json);
}

@JsonSerializable()
class ObservedChain {
  String chain = ''; // todo -> ENUM this
  int height = 0;

  ObservedChain();

  factory ObservedChain.fromJson(Map<String, dynamic> json) =>
      _$ObservedChainFromJson(json);
}

@JsonSerializable()
class PreflightStatus {
  String status = '';
  String? reason = '';
  int code = 0;

  PreflightStatus();

  factory PreflightStatus.fromJson(Map<String, dynamic> json) =>
      _$PreflightStatusFromJson(json);
}

enum TCNodeStatus {
  @JsonValue("Active")
  ACTIVE,
  @JsonValue("Ready")
  READY,
  @JsonValue("Standby")
  STANDBY,
  @JsonValue("Disabled")
  DISABLED,
  @JsonValue("Whitelisted")
  WHITELISTED,
  @JsonValue("Unknown")
  UNKNOWN
}

@JsonSerializable()
class TCNode {
  String address = '';

  TCNodeStatus status;

  PubKeySet? publicKeys;

  int bond = 0;

  bool? requestedToLeave = false;

  bool? forcedToLeave = false;

  int? leaveHeight = 0;

  String ipAddress = '';

  String version = '';

  int slashPoints = 0;

  TCNodeJail? jail;

  int currentAward = 0;

  TCNode({required this.status, required this.publicKeys});

  factory TCNode.fromJson(Map<String, dynamic> json) => _$TCNodeFromJson(json);
}
