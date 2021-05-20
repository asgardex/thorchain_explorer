import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thorchain_explorer/_classes/node_location.dart';
import 'package:thorchain_explorer/_classes/tc_node.dart';

class NodeLocationsProviderState {
  final List<NodeLocation> nodeLocations;

  NodeLocationsProviderState(this.nodeLocations);
}

class NodeLocationsProvider extends StateNotifier<NodeLocationsProviderState> {
  NodeLocationsProvider() : super(NodeLocationsProviderState([]));

  Future<void> fetchLocations(List<TCNode> nodes) async {
    final ips = nodes.map((e) => e.ipAddress).toList();
    final matchingCached =
        (await getCachedLocations()).where((e) => ips.contains(e.ip)).toList();
    final cachedIps = matchingCached.map((e) => e.ip).toList();
    final toQuery =
        ips.where((ip) => !cachedIps.contains(ip) && ip.length > 0).toList();

    List<NodeLocation> queried = [];

    for (final ip in toQuery) {
      final location = await _fetchLocation(ip);
      if (location != null) {
        queried.add(location);
      }
    }

    if (toQuery.length > 0) {
      _updateCached([...matchingCached, ...queried]);
    }

    state = NodeLocationsProviderState([...matchingCached, ...queried]);
  }

  Future<void> _updateCached(List<NodeLocation> nodeLocations) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'nodeLocations', nodeLocations.map((e) => jsonEncode(e)).toList());
  }

  Future<List<NodeLocation>> getCachedLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedNodes = prefs.getStringList('nodeLocations');
    cachedNodes?.forEach((element) {
      print(element.toString());
    });
    return (cachedNodes != null && cachedNodes.length > 0)
        ? cachedNodes.map((e) => NodeLocation.fromJson(jsonDecode(e))).toList()
        : [];
  }

  Future<NodeLocation?> _fetchLocation(String ip) async {
    try {
      final url =
          Uri.https('ipinfo.io', '$ip/json', {'token': '0f0590c0083e36'});
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final nodeLocation = NodeLocation.fromJson(jsonDecode(response.body));
        return nodeLocation;
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      print('error fetching locations... ${e.toString()}');
    }
  }
}
