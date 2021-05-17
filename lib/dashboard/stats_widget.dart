import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/stats.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'dart:math';

import 'package:thorchain_explorer/_widgets/stat_list_item.dart';

class StatsWidget extends HookWidget {
  final Stats stats;

  StatsWidget(this.stats);

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.currency(
      symbol: "",
      decimalDigits: 0,
    );
    final ThemeMode mode = useProvider(userThemeProvider.state);
    final cgProvider = useProvider(coinGeckoProvider.state);

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
          child: Container(
              decoration: containerBoxDecoration(context, mode),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Daily Users",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                              SelectableText(f.format(stats.dailyActiveUsers)),
                            ],
                          ),
                        ),
                        Container(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Monthly Users",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                              SelectableText(
                                  f.format(stats.monthlyActiveUsers)),
                            ],
                          ),
                        ),
                        Container(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Total Users",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                              SelectableText(f.format(stats.totalUsers)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Theme.of(context).dividerColor))),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),

                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Daily Txs",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                              SelectableText(f.format(stats.dailyTx)),
                            ],
                          ),
                        ),
                        Container(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Monthly Txs",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                              SelectableText(f.format(stats.monthlyTx)),
                            ],
                          ),
                        ),
                        Container(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Total Txs",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                              SelectableText(f.format(stats.totalTx)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Theme.of(context).dividerColor))),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),

                  StatListItem(
                      label: "Total Asset Buys",
                      value: f.format(stats.totalAssetBuys)),
                  StatListItem(
                      label: "Total Asset Sells",
                      value: f.format(stats.totalAssetSells)),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SelectableText(
                          "Total Depth",
                          style: TextStyle(
                              color: Theme.of(context).hintColor, fontSize: 12),
                        ),
                        Row(
                          children: [
                            SelectableText(
                                f.format(stats.totalDepth / pow(10, 8))),
                            SelectableText(
                              cgProvider.runePrice != null
                                  ? "(\$${f.format(stats.totalDepth / pow(10, 8).ceil() * cgProvider.runePrice)})"
                                  : "",
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Theme.of(context).dividerColor))),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),
                  StatListItem(
                      label: "Total Deposited Transactions",
                      value: f.format(stats.totalStakeTx)),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SelectableText(
                          "Total Deposited",
                          style: TextStyle(
                              color: Theme.of(context).hintColor, fontSize: 12),
                        ),
                        Row(
                          children: [
                            SelectableText(
                                f.format(stats.totalStaked / pow(10, 8))),
                            SelectableText(
                              cgProvider.runePrice != null
                                  ? "(\$${f.format(stats.totalStaked / pow(10, 8).ceil() * cgProvider.runePrice)})"
                                  : "",
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Theme.of(context).dividerColor))),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),

                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SelectableText(
                          "Total Volume",
                          style: TextStyle(
                              color: Theme.of(context).hintColor, fontSize: 12),
                        ),
                        Row(
                          children: [
                            SelectableText(
                                f.format(stats.totalVolume / pow(10, 8))),
                            SelectableText(
                              cgProvider.runePrice != null
                                  ? "(\$${f.format(stats.totalVolume / pow(10, 8).ceil() * cgProvider.runePrice)})"
                                  : "",
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),

                  // // this is returning the incorrect value in graphql
                  // StatListItem(
                  //   label: "Total Withdraw Transactions",
                  //   value: f.format(stats.totalWithdrawTx),
                  //   hideBorder: true,
                  // ),
                ],
              )),
        ),
      ],
    );
  }
}
