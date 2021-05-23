import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:thorchain_explorer/_classes/node_location.dart';
import 'package:thorchain_explorer/_enums/networks.dart';

class NodeLocationsProviderState {
  final List<NodeLocation> nodeLocations;

  NodeLocationsProviderState(this.nodeLocations);
}

class NodeLocationsProvider extends StateNotifier<NodeLocationsProviderState> {
  Networks network;

  NodeLocationsProvider(this.network) : super(NodeLocationsProviderState([])) {
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    try {
      final selectedNetwork =
          network == Networks.Testnet ? 'testnet' : 'mainnet';

      final url = Uri.http('thorchainbackendutils-m647dnmuea-ue.a.run.app',
          'nodes', {'network': selectedNetwork});
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var l = json.decode(response.body) as List<dynamic>;
        List<NodeLocation> nodesLocations =
            l.map((e) => NodeLocation.fromJson(e)).toList();
        state = NodeLocationsProviderState(nodesLocations);
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
