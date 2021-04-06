import 'dart:convert';

import 'package:thorchain_explorer/_classes/tc_bank_balances.dart';
import 'package:http/http.dart' as http;
import 'package:thorchain_explorer/_enums/networks.dart';

class ThornodeService {
  final String baseUrl;

  ThornodeService(Networks network)
      : baseUrl = (network == Networks.Mainnet)
            ? 'thornode.thorchain.info'
            : 'testnet.thornode.thorchain.info';

  Future<BankBalances> fetchBalances(String address) async {
    final uri = Uri.https(baseUrl, '/bank/balances/$address');
    final response = await http.get(uri).timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return BankBalances.fromJson(json.decode(response.body));
    } else
      throw Exception('Couldn\'t load actions');
  }
}
