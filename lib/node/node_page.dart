import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/tc_node.dart';
import 'package:thorchain_explorer/_gql_queries/gql_queries.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'package:thorchain_explorer/pool/pool_page.dart';

class NodePage extends StatelessWidget {
  final String address;

  NodePage(this.address);

  final f = NumberFormat.currency(
    symbol: "",
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return TCScaffold(
      currentArea: PageOptions.Nodes,
      child: Query(
        options: nodePageQueryOptions(address),
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

          final node = TCNode.fromJson(result.data['node']);

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(node.address,
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 16,
                ),
                Material(
                  elevation: 1,
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                      padding: EdgeInsets.all(16),
                      child: Table(
                          border: TableBorder.all(
                              width: 1, color: Theme.of(context).dividerColor),
                          children: [
                            TableRow(children: [
                              PaddedTableCell(child: SelectableText("Address")),
                              PaddedTableCell(
                                  child: SelectableText(node.address)),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(
                                  child: SelectableText("IP Address")),
                              PaddedTableCell(
                                  child: SelectableText(node.ipAddress)),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(child: SelectableText("Version")),
                              PaddedTableCell(
                                  child: SelectableText(node.version)),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(child: SelectableText("Status")),
                              PaddedTableCell(
                                  child:
                                      SelectableText(node.status.toString())),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(child: SelectableText("Bond")),
                              PaddedTableCell(
                                  child: SelectableText(
                                      f.format(node.bond / pow(10, 8)))),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(
                                  child: SelectableText("Slash Points")),
                              PaddedTableCell(
                                  child: SelectableText(
                                      node.slashPoints.toString())),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(
                                  child: SelectableText("Current Reward")),
                              PaddedTableCell(
                                  child: SelectableText(f
                                      .format(node.currentAward / pow(10, 8)))),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(
                                  child:
                                      SelectableText("Public Keys secp256k1")),
                              PaddedTableCell(
                                  child: SelectableText(
                                      node.publicKeys.secp256k1)),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(
                                  child: SelectableText("Public Keys ed25519")),
                              PaddedTableCell(
                                  child:
                                      SelectableText(node.publicKeys.ed25519)),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(
                                  child: SelectableText("Requested To Leave")),
                              PaddedTableCell(
                                  child: SelectableText(
                                      node.requestedToLeave.toString())),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(
                                  child: SelectableText("Forced To Leave")),
                              PaddedTableCell(
                                  child: SelectableText(
                                      node.forcedToLeave.toString())),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(
                                  child: SelectableText("Leave Height")),
                              PaddedTableCell(
                                  child: SelectableText(
                                      node.leaveHeight.toString())),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(
                                  child: SelectableText("Jail Node Address")),
                              PaddedTableCell(
                                  child: SelectableText(
                                      node.jail.nodeAddr != null
                                          ? node.jail.nodeAddr
                                          : "")),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(
                                  child: SelectableText("Jail Release Height")),
                              PaddedTableCell(
                                  child: SelectableText(
                                      node.jail.releaseHeight != null
                                          ? node.jail.releaseHeight.toString()
                                          : "")),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(
                                  child: SelectableText("Jail Reason")),
                              PaddedTableCell(
                                  child: SelectableText(node.jail.reason != null
                                      ? node.jail.reason
                                      : "")),
                            ]),
                          ])),
                ),
              ]);
        },
      ),
    );
  }
}
