// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tc_bank_balances.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankBalance _$BankBalanceFromJson(Map<String, dynamic> json) {
  return BankBalance()
    ..denom = json['denom'] as String
    ..amount = json['amount'] as String;
}

Map<String, dynamic> _$BankBalanceToJson(BankBalance instance) =>
    <String, dynamic>{
      'denom': instance.denom,
      'amount': instance.amount,
    };

BankBalances _$BankBalancesFromJson(Map<String, dynamic> json) {
  return BankBalances()
    ..height = json['height'] as String
    ..result = (json['result'] as List)
        ?.map((e) =>
            e == null ? null : BankBalance.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BankBalancesToJson(BankBalances instance) =>
    <String, dynamic>{
      'height': instance.height,
      'result': instance.result,
    };
