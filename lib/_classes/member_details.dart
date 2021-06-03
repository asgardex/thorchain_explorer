import 'package:json_annotation/json_annotation.dart';

part 'member_details.g.dart';

@JsonSerializable()
class MemberDetails {
  List<MemberPool> pools = [];

  MemberDetails();

  factory MemberDetails.fromJson(Map<String, dynamic> json) =>
      _$MemberDetailsFromJson(json);
}

/// This is very similar to PoolLiquidityProvider
/// Midgard can query by specific address but not fetch members by pool
/// THORNode can query by specific pool, but not fetch specific address
@JsonSerializable()
class MemberPool {
  String pool = '';
  String? runeAddress = '';
  String? assetAddress = '';
  String liquidityUnits = '0';
  String runeAdded = '0';
  String assetAdded = '0';
  String runeWithdrawn = '0';
  String assetWithdrawn = '0';
  String dateFirstAdded = '';
  String dateLastAdded = '';

  MemberPool();

  factory MemberPool.fromJson(Map<String, dynamic> json) =>
      _$MemberPoolFromJson(json);
}
