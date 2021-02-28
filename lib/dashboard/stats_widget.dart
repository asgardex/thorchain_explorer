import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/stats.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'dart:math';

import 'package:thorchain_explorer/_widgets/stat_list_item.dart';

class StatsWidget extends HookWidget {
  final Stats stats;

  StatsWidget(this.stats);

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            "Stats",
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
        ),
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(4.0),
          child: Container(
              height: 480,
              decoration: containerBoxDecoration(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // StatListItem(label: "Daily Active Users", value: f.format(stats.dailyActiveUsers)),
                  // StatListItem(label: "Monthly Active Users", value: f.format(stats.monthlyActiveUsers)),
                  // StatListItem(label: "Total Users", value: f.format(stats.totalUsers)),
                  StatListItem(
                      label: "Daily Txs", value: f.format(stats.dailyTx)),
                  StatListItem(
                      label: "Monthly Txs", value: f.format(stats.monthlyTx)),
                  StatListItem(
                      label: "Total Txs", value: f.format(stats.totalTx)),
                  StatListItem(
                      label: "Total Asset Buys",
                      value: f.format(stats.totalAssetBuys)),
                  StatListItem(
                      label: "Total Asset Sells",
                      value: f.format(stats.totalAssetSells)),
                  StatListItem(
                      label: "Total Depth",
                      value: f.format(stats.totalDepth / pow(10, 8))),
                  StatListItem(
                      label: "Total Staked Transactions",
                      value: f.format(stats.totalStakeTx)),
                  StatListItem(
                      label: "Total Staked",
                      value: f.format(stats.totalStaked / pow(10, 8))),
                  StatListItem(
                      label: "Total Volume",
                      value: f.format(stats.totalVolume / pow(10, 8))),
                  StatListItem(
                    label: "Total Withdraw Txs",
                    value: f.format(stats.totalWithdrawTx),
                    hideBorder: true,
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
