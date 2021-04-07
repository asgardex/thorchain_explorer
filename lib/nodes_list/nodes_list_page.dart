import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    final ThemeMode mode = useProvider(userThemeProvider.state);

    Future<void> getStarredNodes() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final nodeList = prefs.getStringList('starredNodes');
      if (nodeList != null && nodeList.length > 0) {
        starredNodes.value.addAll(prefs.getStringList('starredNodes'));
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
                {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<TCNode> tcNodes = List<TCNode>.from(
                  result.data['nodes'].map((node) => TCNode.fromJson(node)));

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
                  createNodesGroup(
                      context: context,
                      nodes: activeNodes,
                      groupLabel: "Active Nodes",
                      starredNodes: starredNodes,
                      mode: mode),
                  SizedBox(
                    height: 32,
                  ),
                  createNodesGroup(
                      context: context,
                      nodes: standbyNodes,
                      groupLabel: "Standby Nodes",
                      starredNodes: starredNodes,
                      mode: mode),
                  SizedBox(
                    height: 32,
                  ),
                  createNodesGroup(
                      context: context,
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

Widget createNodesGroup(
    {BuildContext context,
    List<TCNode> nodes,
    String groupLabel,
    ValueNotifier<List<String>> starredNodes,
    ThemeMode mode}) {
  final f = NumberFormat.currency(
    symbol: "",
    decimalDigits: 0,
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(
        padding: EdgeInsets.all(16),
        child: Text(
          groupLabel,
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
      ),
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
              : SingleChildScrollView(
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
                    ],
                    rows: nodes
                        .map((node) => DataRow(
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
                                      Text(f.format(node.bond / pow(10, 8))))
                                ]))
                        .toList(),
                  ),
                ),
        ),
      ),
    ],
  );
}
