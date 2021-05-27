import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:thorchain_explorer/_classes/pool_stats.dart';
import 'package:thorchain_explorer/_classes/tc_action.dart';
import 'package:thorchain_explorer/_classes/tc_node.dart';
import 'package:thorchain_explorer/_enums/networks.dart';

class FetchActionParams {
  int offset;
  int limit;
  String? txId;
  String? address;

  FetchActionParams(
      {this.offset = 0, this.limit = 10, String? txId, String? address}) {
    if (txId != null) {
      this.txId = txId;
    }
    if (address != null) {
      this.address = address;
    }
  }
}

class MidgardService {
  final String baseUrl;

  MidgardService(Networks network)
      : baseUrl = (network == Networks.Mainnet)
            ? 'midgard.thorchain.info'
            : 'testnet.midgard.thorchain.info';

  TcActionResponse _parseActions(String response) {
    return TcActionResponse.fromJson(json.decode(response));
  }

  Future<TcActionResponse> fetchActions(FetchActionParams params) async {
    Map<String, String> queryParameters = {
      'offset': '${params.offset}',
      'limit': '${params.limit}',
    };

    if (params.txId != null) {
      queryParameters.putIfAbsent('txid', () => '${params.txId}');
    }

    if (params.address != null) {
      queryParameters.putIfAbsent('address', () => '${params.address}');
    }

    var uri = Uri.https(baseUrl, '/v2/actions', queryParameters);
    var response =
        await http.get(uri, headers: {}).timeout(Duration(seconds: 5));

    if (response.statusCode == 200)
      return compute(_parseActions, response.body);
    else
      throw Exception('Couldn\'t load actions');
  }

  List<TCNode> _parseNodes(String response) {
    var l = json.decode(response) as List<dynamic>;
    List<TCNode> nodes = l.map((e) => TCNode.fromJson(e)).toList();
    nodes.sort((a, b) => b.bond.compareTo(a.bond));
    return nodes;
  }

  Future<List<TCNode>> fetchNodes() async {
    var uri = Uri.https(baseUrl, '/thorchain/nodes');
    var response = await http.get(uri).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      return compute(_parseNodes, response.body);
    } else
      throw Exception('Couldn\'t load actions');
  }

  Future<PoolStats> fetchPoolStats(String asset) async {
    final uri = Uri.https(baseUrl, '/v2/pool/$asset/stats');
    final response = await http.get(uri).timeout(Duration(seconds: 15));

    if (response.statusCode == 200) {
      return PoolStats.fromJson(jsonDecode(response.body));
    } else
      throw Exception('Couldn\'t load actions');
  }
}
