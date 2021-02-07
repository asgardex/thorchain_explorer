import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thorchain_explorer/_classes/tc_node.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
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
            child: HookBuilder(
              builder: (context) {

                final response = useProvider(nodes);

                return response.when(
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (err, _) => Center(child: Text(err),),
                  data: (tcNodes) {
                    // print(response);

                    // tcNodes.sort((a, b) => int.parse(b.bond).compareTo(int.parse(a.bond)));

                    final activeNodes = tcNodes.where((element) => element.status == TCNodeStatus.ACTIVE).toList();
                    final standbyNodes = tcNodes.where((element) => element.status == TCNodeStatus.STANDBY).toList();
                    final disabledNodes = tcNodes.where((element) => element.status == TCNodeStatus.DISABLED).toList();


                    return Container(
                      child: Column(
                        children: [

                          // ...starredNodes.value.map((e) => Text(e)).toList(),

                          createNodesGroup(context: context, nodes: activeNodes, groupLabel: "Active Nodes", starredNodes: starredNodes),
                          SizedBox(height: 32,),
                          createNodesGroup(context: context, nodes: standbyNodes, groupLabel: "Standby Nodes", starredNodes: starredNodes)
                        ],
                      ),
                    );
                  },
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
              columns: [
                DataColumn(label: Text("")),
                DataColumn(label: Text("Address")),
                DataColumn(label: Text("IP")),
                DataColumn(label: Text("Version")),
                DataColumn(label: Text("Slash Points")),
                DataColumn(label: Text("Current Award")),
                DataColumn(label: Text("Bond")),
              ],
              // border: TableBorder.all(width: 1, color: Theme.of(context).dividerColor),
              rows: nodes.map((node) => DataRow(
                    cells: [
                      DataCell(IconButton(
                        icon: (starredNodes.value.contains(node.nodeAddress))
                          ? Icon(Icons.star, color: Colors.orange,)
                          : Icon(Icons.star_border),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();

                          if (starredNodes.value.contains(node.nodeAddress)) {
                            starredNodes.value.remove(node.nodeAddress);
                            starredNodes.value =
                                List.from(starredNodes.value);
                          } else {
                            starredNodes.value += [node.nodeAddress];
                          }

                          prefs.setStringList('starredNodes', starredNodes.value);
                        },
                      )),
                      DataCell(Text('${node.nodeAddress.substring(0, 8)}...${node.nodeAddress.substring(node.nodeAddress.length - 4)}'),),
                      DataCell(
                          Container(
                            width: 110,
                            child: SelectableText(node.ipAddress)
                          )
                      ),
                      DataCell(Text(node.version)),
                      DataCell(Text(node.slashPoints.toString())),
                      // DataCell(Text(node.currentAward.toString())),
                      // DataCell(Text(node.bond)),
                      DataCell(Text(f.format(int.parse(node.currentAward) / pow(10, 8)))),
                      DataCell(Text(f.format(int.parse(node.bond) / pow(10, 8))))
                    ]
                )).toList()
              ,
            ),
          ),
        ],
      ),
    ),
  );
}
