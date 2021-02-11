import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:thorchain_explorer/_classes/tc_node.dart';
import 'package:http/http.dart' as http;

class ThornodeService {
  List<TCNode> _parseNodes(String response) {
    var l = json.decode(response) as List<dynamic>;
    List<TCNode> nodes = l.map((e) => TCNode.fromJson(e)).toList();
    nodes.sort((a, b) => b.bond.compareTo(a.bond));
    return nodes;
  }

  Future<List<TCNode>> fetchNodes() async {
    var uri = Uri.https('testnet.thornode.thorchain.info', '/thorchain/nodes');
    var response = await http.get(uri).timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return compute(_parseNodes, response.body);
    } else
      throw Exception('Couldn\'t load actions');
  }
}
