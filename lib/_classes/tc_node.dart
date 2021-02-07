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

  @JsonKey(name: 'node_address')
  String nodeAddress;

  @JsonKey(name: 'release_height')
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

// "jail": {
//   "node_address": "tthor15n3jrhlfphc0fxcttjl3pz6xx0430663j4up5k",
//   "release_height": 44454,
//   "reason": "failed to perform keygen"
// },

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
  @JsonValue("Standby") STANDBY,
  @JsonValue("Disabled") DISABLED,
  @JsonValue("Whitelisted") WHITELISTED,
}

@JsonSerializable()
class TCNode {

  @JsonKey(name: 'node_address')
  String nodeAddress;

  TCNodeStatus status;

  @JsonKey(name: 'pub_key_set')
  PubKeySet pubKeySet;

  @JsonKey(name: 'validator_cons_pub_key')
  String validatorConsPubKey;

  String bond;

  @JsonKey(name: 'active_block_height')
  int activeBlockHeight;

  @JsonKey(name: 'bond_address')
  String bondAddress;

  @JsonKey(name: 'status_since')
  int statusSince;

  @JsonKey(name: 'signer_membership')
  List<String> signerMembership;

  @JsonKey(name: 'requested_to_leave')
  bool requestedToLeave;

  @JsonKey(name: 'forced_to_leave')
  bool forcedToLeave;

  @JsonKey(name: 'leave_height')
  int leaveHeight;

  @JsonKey(name: 'ip_address')
  String ipAddress;

  String version;

  @JsonKey(name: 'slash_points')
  int slashPoints;

  TCNodeJail jail;

  @JsonKey(name: 'current_award')
  String currentAward;

  @JsonKey(name: 'observe_chains')
  List<ObservedChain> observedChains;

  @JsonKey(name: 'preflight_status')
  PreflightStatus preflightStatus;

  TCNode();

  factory TCNode.fromJson(Map<String, dynamic> json) => _$TCNodeFromJson(json);

}
