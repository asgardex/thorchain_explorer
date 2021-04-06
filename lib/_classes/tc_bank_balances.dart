import 'package:json_annotation/json_annotation.dart';

part 'tc_bank_balances.g.dart';

@JsonSerializable()
class BankBalance {
  String denom;
  String amount;

  BankBalance();

  factory BankBalance.fromJson(Map<String, dynamic> json) =>
      _$BankBalanceFromJson(json);
}

@JsonSerializable()
class BankBalances {
  String height;
  List<BankBalance> result;

  BankBalances();

  factory BankBalances.fromJson(Map<String, dynamic> json) =>
      _$BankBalancesFromJson(json);
}
