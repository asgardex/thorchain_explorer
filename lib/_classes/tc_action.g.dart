// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tc_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinAmount _$CoinAmountFromJson(Map<String, dynamic> json) {
  return CoinAmount()
    ..asset = json['asset'] as String
    ..amount = json['amount'] as String;
}

Map<String, dynamic> _$CoinAmountToJson(CoinAmount instance) =>
    <String, dynamic>{
      'asset': instance.asset,
      'amount': instance.amount,
    };

ActionTx _$ActionTxFromJson(Map<String, dynamic> json) {
  return ActionTx()
    ..txID = json['txID'] as String
    ..memo = json['memo'] as String
    ..address = json['address'] as String
    ..coins = (json['coins'] as List)
        ?.map((e) =>
            e == null ? null : CoinAmount.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ActionTxToJson(ActionTx instance) => <String, dynamic>{
      'txID': instance.txID,
      'memo': instance.memo,
      'address': instance.address,
      'coins': instance.coins,
    };

ActionMetadataSwap _$ActionMetadataSwapFromJson(Map<String, dynamic> json) {
  return ActionMetadataSwap()
    ..liquidityFee = json['liquidityFee'] as String
    ..tradeSlip = json['tradeSlip'] as String
    ..tradeTarget = json['tradeTarget'] as String
    ..networkFees = (json['networkFees'] as List)
        ?.map((e) =>
            e == null ? null : CoinAmount.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ActionMetadataSwapToJson(ActionMetadataSwap instance) =>
    <String, dynamic>{
      'liquidityFee': instance.liquidityFee,
      'tradeSlip': instance.tradeSlip,
      'tradeTarget': instance.tradeTarget,
      'networkFees': instance.networkFees,
    };

ActionMetadataAddLiquidity _$ActionMetadataAddLiquidityFromJson(
    Map<String, dynamic> json) {
  return ActionMetadataAddLiquidity()
    ..liquidityUnits = json['liquidityUnits'] as String;
}

Map<String, dynamic> _$ActionMetadataAddLiquidityToJson(
        ActionMetadataAddLiquidity instance) =>
    <String, dynamic>{
      'liquidityUnits': instance.liquidityUnits,
    };

ActionMetadataWithdraw _$ActionMetadataWithdrawFromJson(
    Map<String, dynamic> json) {
  return ActionMetadataWithdraw()
    ..liquidityUnits = json['liquidityUnits'] as String
    ..asymmetry = json['asymmetry'] as String
    ..basisPoints = json['basisPoints'] as String
    ..networkFees = (json['networkFees'] as List)
        ?.map((e) =>
            e == null ? null : CoinAmount.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ActionMetadataWithdrawToJson(
        ActionMetadataWithdraw instance) =>
    <String, dynamic>{
      'liquidityUnits': instance.liquidityUnits,
      'asymmetry': instance.asymmetry,
      'basisPoints': instance.basisPoints,
      'networkFees': instance.networkFees,
    };

ActionMetadataRefund _$ActionMetadataRefundFromJson(Map<String, dynamic> json) {
  return ActionMetadataRefund()
    ..networkFees = (json['networkFees'] as List)
        ?.map((e) =>
            e == null ? null : CoinAmount.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..reason = json['reason'] as String;
}

Map<String, dynamic> _$ActionMetadataRefundToJson(
        ActionMetadataRefund instance) =>
    <String, dynamic>{
      'networkFees': instance.networkFees,
      'reason': instance.reason,
    };

ActionMetadata _$ActionMetadataFromJson(Map<String, dynamic> json) {
  return ActionMetadata()
    ..swap = json['swap'] == null
        ? null
        : ActionMetadataSwap.fromJson(json['swap'] as Map<String, dynamic>)
    ..addLiquidity = json['addLiquidity'] == null
        ? null
        : ActionMetadataAddLiquidity.fromJson(
            json['addLiquidity'] as Map<String, dynamic>)
    ..withdraw = json['withdraw'] == null
        ? null
        : ActionMetadataWithdraw.fromJson(
            json['withdraw'] as Map<String, dynamic>)
    ..refund = json['refund'] == null
        ? null
        : ActionMetadataRefund.fromJson(json['refund'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ActionMetadataToJson(ActionMetadata instance) =>
    <String, dynamic>{
      'swap': instance.swap,
      'addLiquidity': instance.addLiquidity,
      'withdraw': instance.withdraw,
      'refund': instance.refund,
    };

TcAction _$TcActionFromJson(Map<String, dynamic> json) {
  return TcAction()
    ..pools = (json['pools'] as List)?.map((e) => e as String)?.toList()
    ..type = json['type'] as String
    ..status = json['status'] as String
    ..inputs = (json['in'] as List)
        ?.map((e) =>
            e == null ? null : ActionTx.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..outputs = (json['out'] as List)
        ?.map((e) =>
            e == null ? null : ActionTx.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..date = json['date'] as String
    ..height = json['height'] as String
    ..metadata = json['metadata'] == null
        ? null
        : ActionMetadata.fromJson(json['metadata'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TcActionToJson(TcAction instance) => <String, dynamic>{
      'pools': instance.pools,
      'type': instance.type,
      'status': instance.status,
      'in': instance.inputs,
      'out': instance.outputs,
      'date': instance.date,
      'height': instance.height,
      'metadata': instance.metadata,
    };

TcActionResponse _$TcActionResponseFromJson(Map<String, dynamic> json) {
  return TcActionResponse()
    ..count = json['count'] as String
    ..actions = (json['actions'] as List)
        ?.map((e) =>
            e == null ? null : TcAction.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TcActionResponseToJson(TcActionResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'actions': instance.actions,
    };
