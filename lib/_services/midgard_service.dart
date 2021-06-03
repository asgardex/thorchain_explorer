import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:thorchain_explorer/_classes/member_details.dart';
import 'package:thorchain_explorer/_classes/pool_stats.dart';
import 'package:thorchain_explorer/_classes/stats.dart';
import 'package:thorchain_explorer/_classes/tc_action.dart';
import 'package:thorchain_explorer/_classes/tc_node.dart';
import 'package:thorchain_explorer/_enums/networks.dart';

class FetchActionParams {
  int offset;
  int limit;
  String? txId;
  String? address;
  String? asset;

  FetchActionParams(
      {this.offset = 0,
      this.limit = 10,
      String? txId,
      String? address,
      String? asset}) {
    if (txId != null) {
      this.txId = txId;
    }
    if (address != null) {
      this.address = address;
    }
    if (asset != null) {
      this.asset = asset;
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
      String id = params.txId ?? '';
      if (id.indexOf('0x') == 0 || (id.indexOf('0X') == 0)) {
        id = id.substring(2);
      }

      queryParameters.putIfAbsent('txid', () => '$id');
    }

    if (params.address != null) {
      queryParameters.putIfAbsent('address', () => '${params.address}');
    }

    if (params.asset != null) {
      queryParameters.putIfAbsent('asset', () => '${params.asset}');
    }

    var uri = Uri.https(baseUrl, '/v2/actions', queryParameters);
    var response =
        await http.get(uri, headers: {}).timeout(Duration(seconds: 30));

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
    var response = await http.get(uri).timeout(Duration(seconds: 15));

    if (response.statusCode == 200) {
      return compute(_parseNodes, response.body);
    } else
      throw Exception('Couldn\'t load nodes');
  }

  Future<PoolStats> fetchPoolStats(String asset) async {
    final uri = Uri.https(baseUrl, '/v2/pool/$asset/stats');
    final response = await http.get(uri).timeout(Duration(seconds: 15));

    if (response.statusCode == 200) {
      return PoolStats.fromJson(jsonDecode(response.body));
    } else
      throw Exception('Couldn\'t load pool stats');
  }

  Future<Stats> fetchStats() async {
    final uri = Uri.https(baseUrl, '/v2/stats');
    final response = await http.get(uri).timeout(Duration(seconds: 15));

    if (response.statusCode == 200) {
      return Stats.fromJson(jsonDecode(response.body));
    } else
      throw Exception('Couldn\'t load stats');
  }

  Future<MemberDetails> fetchMemberDetails(String address) async {
    final uri = Uri.https(baseUrl, '/v2/member/$address');
    final response = await http.get(uri).timeout(Duration(seconds: 15));

    if (response.statusCode == 200) {
      return MemberDetails.fromJson(jsonDecode(response.body));
    } else
      // If no me
      return new MemberDetails();
  }
}
