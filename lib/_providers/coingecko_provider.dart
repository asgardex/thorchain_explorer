import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:thorchain_explorer/_classes/coingecko_price.dart';

class CoinGeckoProviderState {
  final double runePrice;

  CoinGeckoProviderState(this.runePrice);
}

class CoinGeckoProvider extends StateNotifier<CoinGeckoProviderState> {
  CoinGeckoProvider() : super(CoinGeckoProviderState(0)) {
    fetchRunePrice();
  }

  Future<void> fetchRunePrice() async {
    try {
      final url = Uri.https('api.coingecko.com', 'api/v3/simple/price',
          {'ids': 'thorchain', 'vs_currencies': 'usd'});
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final price = CoinGeckoPrice.fromJson(jsonDecode(response.body));
        state = CoinGeckoProviderState(price.thorchain.usd);
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
