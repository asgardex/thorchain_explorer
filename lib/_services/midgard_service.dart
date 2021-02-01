import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:thorchain_explorer/_classes/tc_action.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_providers/tc_actions_provider.dart';

class MidgardService {

  TcActionResponse _parseActions(String response) {
    // var l = json.decode(response) as List<dynamic>;
    // List<TcAction> actions = l.map((e) => TcAction.fromJson(e)).toList();
    // return actions;
    // var m = json.decode(response) as Map<String, dynamic>;
    return TcActionResponse.fromJson(json.decode(response));
  }

  Future<TcActionResponse> fetchActions(FetchActionParams params) async {

    print('midgard fetch actions called');

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

    var uri = Uri.https('testnet.midgard.thorchain.info', '/v2/actions', queryParameters);
    var response = await http.get(uri, headers: {
      // HttpHeaders.authorizationHeader: 'Token $token',
      // HttpHeaders.contentTypeHeader: 'application/json',
    }).timeout(Duration(seconds: 5));


    // final response = await http
    //     .get('https://jsonplaceholder.typicode.com/photos')
    //     .timeout(Duration(seconds: 5));
    if (response.statusCode == 200)
      return compute(_parseActions, response.body);
    else
      throw Exception('Couldn\'t load actions');
  }

}
