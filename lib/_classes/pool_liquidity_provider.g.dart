// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pool_liquidity_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoolLiquidityProvider _$PoolLiquidityProviderFromJson(
    Map<String, dynamic> json) {
  return PoolLiquidityProvider()
    ..asset = json['asset'] as String
    ..assetAddress = json['asset_address'] as String?
    ..runeAddress = json['rune_address'] as String?
    ..lastAddHeight = json['last_add_height'] as int
    ..lastWithdrawHeight = json['last_withdraw_height'] as int?
    ..units = json['units'] as String
    ..pendingRune = json['pending_rune'] as String
    ..pendingAsset = json['pending_asset'] as String
    ..pendingTxId = json['pending_tx_Id'] as String?
    ..runeDepositValue = json['rune_deposit_value'] as String
    ..assetDepositValue = json['asset_deposit_value'] as String;
}

Map<String, dynamic> _$PoolLiquidityProviderToJson(
        PoolLiquidityProvider instance) =>
    <String, dynamic>{
      'asset': instance.asset,
      'asset_address': instance.assetAddress,
      'rune_address': instance.runeAddress,
      'last_add_height': instance.lastAddHeight,
      'last_withdraw_height': instance.lastWithdrawHeight,
      'units': instance.units,
      'pending_rune': instance.pendingRune,
      'pending_asset': instance.pendingAsset,
      'pending_tx_Id': instance.pendingTxId,
      'rune_deposit_value': instance.runeDepositValue,
      'asset_deposit_value': instance.assetDepositValue,
    };
