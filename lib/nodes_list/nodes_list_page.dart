import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thorchain_explorer/_classes/node_location.dart';
import 'package:thorchain_explorer/_classes/tc_network.dart';
import 'package:thorchain_explorer/_classes/tc_node.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_gql_queries/gql_queries.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';

class NodesListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final starredNodes = useState<List<String>>([]);
    final ThemeMode mode = useProvider(userThemeProvider);

    Future<void> getStarredNodes() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final nodeList = prefs.getStringList('starredNodes');
      if (nodeList != null && nodeList.length > 0) {
        starredNodes.value.addAll(prefs.getStringList('starredNodes') ?? []);
      }
      return;
    }

    useEffect(() {
      getStarredNodes();
      return;
    }, []);

    return TCScaffold(
        currentArea: PageOptions.Nodes,
        child: LayoutBuilder(builder: (context, constraints) {
          return Query(
            options: nodesListPageQueryOptions(),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<TCNode> tcNodes = List<TCNode>.from(
                  result.data?['nodes'].map((node) => TCNode.fromJson(node)));

              TCNetwork network = TCNetwork.fromJson(result.data?['network']);

              final activeNodes = tcNodes
                  .where((element) => element.status == TCNodeStatus.ACTIVE)
                  .toList();
              final standbyNodes = tcNodes
                  .where((element) => element.status == TCNodeStatus.STANDBY)
                  .toList();
              final readyNodes = tcNodes
                  .where((element) => element.status == TCNodeStatus.READY)
                  .toList();

              // final disabledNodes = tcNodes.where((element) => element.status == TCNodeStatus.DISABLED).toList();

              return Column(
                children: [
                  NodesGroup(
                      nodes: activeNodes,
                      groupLabel: "Active Nodes",
                      starredNodes: starredNodes,
                      mode: mode,
                      bondMetrics: network.bondMetrics?.active ?? null),
                  SizedBox(
                    height: 32,
                  ),
                  NodesGroup(
                      nodes: standbyNodes,
                      groupLabel: "Standby Nodes",
                      starredNodes: starredNodes,
                      mode: mode,
                      bondMetrics: network.bondMetrics?.standby ?? null),
                  SizedBox(
                    height: 32,
                  ),
                  NodesGroup(
                      nodes: readyNodes,
                      groupLabel: "Ready Nodes",
                      starredNodes: starredNodes,
                      mode: mode)
                ],
              );
            },
          );
        }));
  }
}

class NodesGroup extends HookWidget {
  final List<TCNode> nodes;
  final String groupLabel;
  final ValueNotifier<List<String>> starredNodes;
  final ThemeMode mode;
  final BondMetricsStat? bondMetrics;
  final f = NumberFormat.currency(
    symbol: "",
    decimalDigits: 0,
  );

  NodesGroup(
      {required this.nodes,
      required this.groupLabel,
      required this.starredNodes,
      required this.mode,
      this.bondMetrics});

  @override
  Widget build(BuildContext context) {
    final nodeLocationsState = useProvider(nodeLocationsProvider);
    final nodeLocations = nodeLocationsState.nodeLocations;

    nodes.sort((a, b) => b.bond.compareTo(a.bond));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(4.0),
          child: Container(
            decoration: containerBoxDecoration(context, mode),
            child: nodes.length <= 0
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: Text("No $groupLabel Found"),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Theme.of(context).dividerColor))),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(groupLabel,
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            ?.fontSize)),
                              ],
                            ),
                            (bondMetrics != null)
                                ? Container(
                                    // height: 200,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            NodeListVersionSummary(nodes),
                                            BondMetric("Total Bond",
                                                bondMetrics?.totalBond ?? 0),
                                            BondMetric("Average Bond",
                                                bondMetrics?.averageBond ?? 0),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            BondMetric("Max Bond",
                                                bondMetrics?.maximumBond ?? 0),
                                            BondMetric("Median Bond",
                                                bondMetrics?.medianBond ?? 0),
                                            BondMetric("Minimum Bond",
                                                bondMetrics?.minimumBond ?? 0),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          showCheckboxColumn: false,
                          columns: [
                            DataColumn(label: Text("")),
                            DataColumn(label: Text("Address")),
                            DataColumn(label: Text("IP")),
                            DataColumn(label: Text("Version")),
                            DataColumn(label: Text("Slash Points")),
                            DataColumn(label: Text("Current Award")),
                            DataColumn(label: Text("Bond")),
                            DataColumn(label: Text("Org")),
                            DataColumn(label: Text("City")),
                            DataColumn(label: Text("Region")),
                            DataColumn(label: Text("Country"))
                          ],
                          rows: nodes.map((node) {
                            NodeLocation? locationMatch =
                                nodeLocations.firstWhere(
                              (location) => location.ip == node.ipAddress,
                              orElse: () => NodeLocation(),
                            );

                            return DataRow(
                                onSelectChanged: (_) {
                                  Navigator.pushNamed(
                                      context, '/nodes/${node.address}');
                                },
                                cells: [
                                  DataCell(IconButton(
                                    icon: (starredNodes.value
                                            .contains(node.address))
                                        ? Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                          )
                                        : Icon(Icons.star_border),
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      if (starredNodes.value
                                          .contains(node.address)) {
                                        starredNodes.value.remove(node.address);
                                        starredNodes.value =
                                            List.from(starredNodes.value);
                                      } else {
                                        starredNodes.value += [node.address];
                                      }

                                      prefs.setStringList(
                                          'starredNodes', starredNodes.value);
                                    },
                                  )),
                                  DataCell(
                                    Text(
                                        '${node.address.substring(0, 8)}...${node.address.substring(node.address.length - 4)}'),
                                  ),
                                  DataCell(Container(
                                      width: 110,
                                      child: SelectableText(node.ipAddress))),
                                  DataCell(Text(node.version)),
                                  DataCell(Text(node.slashPoints.toString())),
                                  DataCell(Text(f
                                      .format(node.currentAward / pow(10, 8)))),
                                  DataCell(
                                      Text(f.format(node.bond / pow(10, 8)))),
                                  DataCell(Text(locationMatch.org ?? '')),
                                  DataCell(Text(locationMatch.city ?? '')),
                                  DataCell(Text(locationMatch.region ?? '')),
                                  DataCell(Text(locationMatch.country ?? ''))
                                ]);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

class BondMetric extends HookWidget {
  final String label;
  final int value;
  final f = NumberFormat.currency(
    symbol: "",
    decimalDigits: 0,
  );

  BondMetric(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final cgProvider = useProvider(coinGeckoProvider);

    return Container(
      width: 200,
      child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                label,
                style:
                    TextStyle(color: Theme.of(context).hintColor, fontSize: 12),
              ),
              Row(
                children: [
                  SelectableText(f.format(value / pow(10, 8))),
                  SelectableText(
                    cgProvider.runePrice != null
                        ? "(\$${f.format(value / pow(10, 8).ceil() * cgProvider.runePrice)})"
                        : "",
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          padding: EdgeInsets.only(right: 16, top: 8)),
    );
  }
}

class NodeListVersionSummary extends HookWidget {
  final List<TCNode> nodes;

  NodeListVersionSummary(this.nodes);

  @override
  Widget build(BuildContext context) {
    final versionProvider = useProvider(nodeVersionProvider);

    return versionProvider.maybeWhen(
        data: (version) {
          final v =
              version.current != version.next ? version.next : version.current;

          final int nodesOnVersion = nodes.fold(0, (int count, node) {
            if (node.version == v) {
              count = count + 1;
            }
            return count;
          });

          return Container(
            width: 200,
            child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      '% nodes on v$v',
                      style: TextStyle(
                          color: Theme.of(context).hintColor, fontSize: 12),
                    ),
                    SelectableText(((nodesOnVersion / nodes.length) * 100)
                            .toStringAsFixed(0) +
                        "%"),
                  ],
                ),
                padding: EdgeInsets.only(right: 16, top: 8)),
          );
        },
        orElse: () => Container(
              width: 200,
              child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        '% nodes on -',
                        style: TextStyle(
                            color: Theme.of(context).hintColor, fontSize: 12),
                      ),
                      SelectableText("-")
                    ],
                  ),
                  padding: EdgeInsets.only(right: 16, top: 8)),
            ));
  }
}
