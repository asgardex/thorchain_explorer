import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/tc_network.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/stat_item.dart';

class NetworkWidget extends HookWidget {
  final TCNetwork network;
  NetworkWidget(this.network);

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.currency(
      symbol: "",
      decimalDigits: 0,
    );
    final ThemeMode mode = useProvider(userThemeProvider);
    final cgProvider = useProvider(coinGeckoProvider);
    final rowDecoration = BoxDecoration(
        border: Border(
            bottom:
                BorderSide(width: 1, color: Theme.of(context).dividerColor)));
    final rowPadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                "Network",
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: FlatButton(
                child: Row(
                  children: [
                    Text(
                      'View More',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: Theme.of(context).accentColor,
                    )
                  ],
                ),
                onPressed: () => Navigator.pushNamed(context, '/network'),
              ),
            )
          ],
        ),
        Material(
          elevation: 1,
          child: Container(
            decoration: containerBoxDecoration(context, mode),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 225,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Bonding APY",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                              SelectableText(((network.bondingAPY ?? 0) * 100)
                                      .toStringAsFixed(2) +
                                  '%')
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 225,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Liquidity APY",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                              SelectableText(((network.liquidityAPY ?? 0) * 100)
                                      .toStringAsFixed(2) +
                                  '%'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: rowDecoration,
                  padding: rowPadding,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 225,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Total Standby Bonded",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                              Row(
                                children: [
                                  SelectableText(f.format((network.bondMetrics!
                                              .standby?.totalBond ??
                                          0) /
                                      pow(10, 8))),
                                  SelectableText(
                                    cgProvider.runePrice != null
                                        ? "(\$${f.format((network.bondMetrics!.standby?.totalBond ?? 0) / pow(10, 8).ceil() * cgProvider.runePrice)})"
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
                        ),
                      ),
                      Container(
                        width: 225,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Total Active Bonded",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                              Row(
                                children: [
                                  SelectableText(f.format(
                                      (network.bondMetrics!.active?.totalBond ??
                                              0) /
                                          pow(10, 8))),
                                  SelectableText(
                                    cgProvider.runePrice != null
                                        ? "(\$${f.format((network.bondMetrics!.active?.totalBond ?? 0) / pow(10, 8).ceil() * cgProvider.runePrice)})"
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
                        ),
                      ),
                    ],
                  ),
                  decoration: rowDecoration,
                  padding: rowPadding,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 225,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Active Node Count",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                              SelectableText(f.format(network.activeNodeCount))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 225,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                "Standby Node Count",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12),
                              ),
                              SelectableText(f.format(network.standbyNodeCount))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: rowDecoration,
                  padding: rowPadding,
                ),
                Container(
                  decoration: rowDecoration,
                  padding: rowPadding,
                  child: Row(
                    children: [
                      StatItem(
                          label: "Next Churn Height",
                          child: SelectableText(
                              network.nextChurnHeight.toString())),
                    ],
                  ),
                ),
                Container(
                  decoration: rowDecoration,
                  padding: rowPadding,
                  child: Row(
                    children: [
                      StatItem(
                          label: "Pool Activation Countdown",
                          child: SelectableText(
                              network.poolActivationCountdown.toString())),
                    ],
                  ),
                ),
                Container(
                  decoration: rowDecoration,
                  padding: rowPadding,
                  child: Row(
                    children: [
                      StatItem(
                          label: "Pool Share Factor",
                          child: SelectableText(
                              ((network.poolShareFactor ?? 0) * 100)
                                      .toStringAsFixed(2) +
                                  '%')),
                    ],
                  ),
                ),
                Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SelectableText(
                          "Total Reserve",
                          style: TextStyle(
                              color: Theme.of(context).hintColor, fontSize: 12),
                        ),
                        Row(
                          children: [
                            SelectableText(f.format(
                                (network.totalReserve ?? 0) / pow(10, 8))),
                            SelectableText(
                              cgProvider.runePrice != null
                                  ? "(\$${f.format((network.totalReserve ?? 0) / pow(10, 8).ceil() * cgProvider.runePrice)})"
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
                    decoration: rowDecoration,
                    padding: rowPadding),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SelectableText(
                        "Total Pooled Rune",
                        style: TextStyle(
                            color: Theme.of(context).hintColor, fontSize: 12),
                      ),
                      Row(
                        children: [
                          SelectableText(f.format(
                              (network.totalPooledRune ?? 0) / pow(10, 8))),
                          SelectableText(
                            cgProvider.runePrice != null
                                ? "(\$${f.format((network.totalPooledRune ?? 0) / pow(10, 8).ceil() * cgProvider.runePrice)})"
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
                  padding: rowPadding,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
