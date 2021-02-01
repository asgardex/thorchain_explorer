import 'package:json_annotation/json_annotation.dart';

part 'coingecko_price.g.dart';

@JsonSerializable()
class USDPrice {

  USDPrice();

  double usd;

  factory USDPrice.fromJson(Map<String, dynamic> json) => _$USDPriceFromJson(json);
}

@JsonSerializable()
class CoinGeckoPrice {

  CoinGeckoPrice();

  USDPrice thorchain;

  factory CoinGeckoPrice.fromJson(Map<String, dynamic> json) => _$CoinGeckoPriceFromJson(json);
}
