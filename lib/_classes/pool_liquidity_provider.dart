import 'package:json_annotation/json_annotation.dart';

part 'pool_liquidity_provider.g.dart';

@JsonSerializable()
class PoolLiquidityProvider {
  String asset = '';

  @JsonKey(name: 'asset_address')
  String? assetAddress = '';

  @JsonKey(name: 'rune_address')
  String? runeAddress = '';

  @JsonKey(name: 'last_add_height')
  int lastAddHeight = 0;

  @JsonKey(name: 'last_withdraw_height')
  int? lastWithdrawHeight = 0;

  String units = '';

  @JsonKey(name: 'pending_rune')
  String pendingRune = '0';

  @JsonKey(name: 'pending_asset')
  String pendingAsset = '0';

  @JsonKey(name: 'pending_tx_Id')
  String? pendingTxId = '';

  @JsonKey(name: 'rune_deposit_value')
  String runeDepositValue = '0';

  @JsonKey(name: 'asset_deposit_value')
  String assetDepositValue = '0';

  PoolLiquidityProvider();

  factory PoolLiquidityProvider.fromJson(Map<String, dynamic> json) =>
      _$PoolLiquidityProviderFromJson(json);
}
