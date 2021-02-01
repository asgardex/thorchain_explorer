import 'package:json_annotation/json_annotation.dart';

part 'tc_action.g.dart';

@JsonSerializable()
class CoinAmount {

  String asset;
  String amount;

  CoinAmount();

  factory CoinAmount.fromJson(Map<String, dynamic> json) => _$CoinAmountFromJson(json);
}

@JsonSerializable()
class ActionTx {

  String txID;
  String memo;
  String address;
  List<CoinAmount> coins;

  ActionTx();

  factory ActionTx.fromJson(Map<String, dynamic> json) => _$ActionTxFromJson(json);
}

@JsonSerializable()
class ActionMetadataSwap {
  String liquidityFee;
  String tradeSlip;
  String tradeTarget;
  List<CoinAmount> networkFees;

  ActionMetadataSwap();

  factory ActionMetadataSwap.fromJson(Map<String, dynamic> json) => _$ActionMetadataSwapFromJson(json);
}

@JsonSerializable()
class ActionMetadataAddLiquidity {
  String liquidityUnits;

  ActionMetadataAddLiquidity();

  factory ActionMetadataAddLiquidity.fromJson(Map<String, dynamic> json) => _$ActionMetadataAddLiquidityFromJson(json);
}

@JsonSerializable()
class ActionMetadataWithdraw {
  String liquidityUnits;
  String asymmetry;
  String basisPoints;
  List<CoinAmount> networkFees;

  ActionMetadataWithdraw();

  factory ActionMetadataWithdraw.fromJson(Map<String, dynamic> json) => _$ActionMetadataWithdrawFromJson(json);
}

@JsonSerializable()
class ActionMetadataRefund {
  List<CoinAmount> networkFees;
  String reason;

  ActionMetadataRefund();

  factory ActionMetadataRefund.fromJson(Map<String, dynamic> json) => _$ActionMetadataRefundFromJson(json);
}

@JsonSerializable()
class ActionMetadata {

  ActionMetadataSwap swap;
  ActionMetadataAddLiquidity addLiquidity;
  ActionMetadataWithdraw withdraw;
  ActionMetadataRefund refund;

  ActionMetadata();

  factory ActionMetadata.fromJson(Map<String, dynamic> json) => _$ActionMetadataFromJson(json);
}

@JsonSerializable()
class TcAction {

  List<String> pools;
  String type; // TODO convert to enum
  String status; // TODO convert to enum

  @JsonKey(name: 'in') // renamed since property cannot be named 'in' in dart
  List<ActionTx> inputs;

  @JsonKey(name: 'out') // renamed for consistency with in
  List<ActionTx> outputs;

  String date;
  String height;
  ActionMetadata metadata;

  TcAction();

  factory TcAction.fromJson(Map<String, dynamic> json) => _$TcActionFromJson(json);

}

@JsonSerializable()
class TcActionResponse {
  String count;
  List<TcAction> actions;

  TcActionResponse();

  factory TcActionResponse.fromJson(Map<String, dynamic> json) => _$TcActionResponseFromJson(json);
}
