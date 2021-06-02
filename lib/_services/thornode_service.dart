import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:thorchain_explorer/_classes/pool_liquidity_provider.dart';
import 'package:thorchain_explorer/_classes/tc_bank_balances.dart';
import 'package:http/http.dart' as http;
import 'package:thorchain_explorer/_classes/tc_node_version.dart';
import 'package:thorchain_explorer/_enums/networks.dart';

List<PoolLiquidityProvider> _parseLps(String response) {
  var l = json.decode(response) as List<dynamic>;
  List<PoolLiquidityProvider> lps =
      l.map((e) => PoolLiquidityProvider.fromJson(e)).toList();
  return lps;
}

class ThornodeService {
  final String baseUrl;

  ThornodeService(Networks network)
      : baseUrl = (network == Networks.Mainnet)
            ? 'thornode.thorchain.info'
            : 'testnet.thornode.thorchain.info';

  Future<BankBalances> fetchBalances(String address) async {
    final uri = Uri.https(baseUrl, '/bank/balances/$address');
    final response = await http.get(uri).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      return BankBalances.fromJson(json.decode(response.body));
    } else
      throw Exception('Couldn\'t load actions');
  }

  Future<TCNodeVersion> fetchNodeVersion() async {
    final uri = Uri.https(baseUrl, '/thorchain/version');
    final response = await http.get(uri).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      return TCNodeVersion.fromJson(json.decode(response.body));
    } else
      throw Exception('Couldn\'t load actions');
  }

  Future<List<PoolLiquidityProvider>> fetchPoolLps(String pool) async {
    final uri = Uri.https(baseUrl, '/thorchain/pool/$pool/liquidity_providers');
    final response = await http.get(uri).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      return compute(_parseLps, response.body);
    } else
      throw Exception('Couldn\'t load actions');
  }
}
