import 'package:json_annotation/json_annotation.dart';

part 'tc_node.g.dart';

@JsonSerializable()
class PubKeySet {

  String secp256k1;
  String ed25519;

  PubKeySet();
  factory PubKeySet.fromJson(Map<String, dynamic> json) => _$PubKeySetFromJson(json);

}

@JsonSerializable()
class TCNodeJail {

  String nodeAddr;

  int releaseHeight;

  String reason;

  TCNodeJail();

  factory TCNodeJail.fromJson(Map<String, dynamic> json) => _$TCNodeJailFromJson(json);

}

@JsonSerializable()
class ObservedChain {

  String chain; // todo -> ENUM this
  int height;

  ObservedChain();

  factory ObservedChain.fromJson(Map<String, dynamic> json) => _$ObservedChainFromJson(json);

}

@JsonSerializable()
class PreflightStatus {

  String status;
  String reason;
  int code;

  PreflightStatus();

  factory PreflightStatus.fromJson(Map<String, dynamic> json) => _$PreflightStatusFromJson(json);

}

enum TCNodeStatus {
  @JsonValue("Active") ACTIVE,
  @JsonValue("Ready") READY,
  @JsonValue("Standby") STANDBY,
  @JsonValue("Disabled") DISABLED,
  @JsonValue("Whitelisted") WHITELISTED,
}

@JsonSerializable()
class TCNode {

  String address;

  TCNodeStatus status;

  PubKeySet publicKeys;

  int bond;

  bool requestedToLeave;

  bool forcedToLeave;

  int leaveHeight;

  String ipAddress;

  String version;

  int slashPoints;

  TCNodeJail jail;

  int currentAward;

  TCNode();

  factory TCNode.fromJson(Map<String, dynamic> json) => _$TCNodeFromJson(json);

}
