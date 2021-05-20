// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coingecko_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

USDPrice _$USDPriceFromJson(Map<String, dynamic> json) {
  return USDPrice(
    usd: (json['usd'] as num).toDouble(),
  );
}

Map<String, dynamic> _$USDPriceToJson(USDPrice instance) => <String, dynamic>{
      'usd': instance.usd,
    };

CoinGeckoPrice _$CoinGeckoPriceFromJson(Map<String, dynamic> json) {
  return CoinGeckoPrice(
    thorchain: USDPrice.fromJson(json['thorchain'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CoinGeckoPriceToJson(CoinGeckoPrice instance) =>
    <String, dynamic>{
      'thorchain': instance.thorchain,
    };
