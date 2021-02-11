import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thorchain_explorer/_classes/tc_node.dart';
import 'package:thorchain_explorer/_gql_queries/gql_queries.dart';
import 'package:thorchain_explorer/_widgets/app_bar.dart';
import 'package:thorchain_explorer/_widgets/fluid_container.dart';

class NodesListPage extends HookWidget {

  @override
  Widget build(BuildContext context) {

    final starredNodes = useState<List<String>>([]);

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

    return Scaffold(
      appBar: ExplorerAppBar(),
      body: LayoutBuilder(builder: (context, constraints) {

        return SingleChildScrollView(
          child: FluidContainer(
            child: Query(
              options: nodesListPageQueryOptions(),
              builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
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

                final activeNodes = tcNodes.where((element) => element.status == TCNodeStatus.ACTIVE).toList();
                final standbyNodes = tcNodes.where((element) => element.status == TCNodeStatus.STANDBY).toList();
                // final disabledNodes = tcNodes.where((element) => element.status == TCNodeStatus.DISABLED).toList();

                return Container(
                  child: Column(
                    children: [
                      createNodesGroup(context: context, nodes: activeNodes, groupLabel: "Active Nodes", starredNodes: starredNodes),
                      SizedBox(height: 32,),
                      createNodesGroup(context: context, nodes: standbyNodes, groupLabel: "Standby Nodes", starredNodes: starredNodes)
                    ],
                  )
                );

              },
            )


          )
        );
      }
    ));
  }
}

Widget createNodesGroup({BuildContext context, List<TCNode> nodes, String groupLabel, ValueNotifier<List<String>> starredNodes}) {

  final f = NumberFormat.currency(
    symbol: "",
    decimalDigits: 0,
  );

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              groupLabel,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Theme.of(context).dividerColor)
                )
            ),
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
              rows: nodes.map((node) => DataRow(
                onSelectChanged: (_) {
                  Navigator.pushNamed(context, '/nodes/${node.address}');
                },
                cells: [
                  DataCell(IconButton(
                    icon: (starredNodes.value.contains(node.address))
                      ? Icon(Icons.star, color: Colors.orange,)
                      : Icon(Icons.star_border),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();

                      if (starredNodes.value.contains(node.address)) {
                        starredNodes.value.remove(node.address);
                        starredNodes.value =
                            List.from(starredNodes.value);
                      } else {
                        starredNodes.value += [node.address];
                      }

                      prefs.setStringList('starredNodes', starredNodes.value);
                    },
                  )),
                  DataCell(Text('${node.address.substring(0, 8)}...${node.address.substring(node.address.length - 4)}'),),
                  DataCell(
                      Container(
                        width: 110,
                        child: SelectableText(node.ipAddress)
                      )
                  ),
                  DataCell(Text(node.version)),
                  DataCell(Text(node.slashPoints.toString())),
                  DataCell(Text(f.format(node.currentAward / pow(10, 8)))),
                  DataCell(Text(f.format(node.bond / pow(10, 8))))
                ])
              ).toList(),
            ),
          ),
        ],
      ),
    ),
  );
}
