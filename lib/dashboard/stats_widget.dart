import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/stats.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/error_display.dart';
import 'package:thorchain_explorer/_widgets/stat_item.dart';
import 'dart:math';

class StatsWidget extends HookWidget {
  final AsyncValue<Stats> stats;

  StatsWidget(this.stats);

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.currency(
      symbol: "",
      decimalDigits: 0,
    );
    final rowDecoration = BoxDecoration(
        border: Border(
            bottom:
                BorderSide(width: 1, color: Theme.of(context).dividerColor)));
    final rowPadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
    final ThemeMode mode = useProvider(userThemeProvider);

    return stats.when(
        loading: () => Container(),
        error: (error, stack) {
          print(error);
          print(stack);
          return ErrorDisplay(subHeader: 'Error loading stats');
        },
        data: (data) => Column(
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
                        children: [
                          Container(
                            child: Row(
                              children: [
                                StatItem(
                                    label: 'Daily Active Users',
                                    child: SelectableText(f.format(
                                        int.tryParse(data.dailyActiveUsers) ??
                                            0))),
                                StatItem(
                                    label: 'Monthly Active Users',
                                    child: SelectableText(f.format(
                                        int.tryParse(data.monthlyActiveUsers) ??
                                            0))),
                              ],
                            ),
                            decoration: rowDecoration,
                            padding: rowPadding,
                          ),
                          Container(
                            child: Row(
                              children: [
                                StatItem(
                                    label: 'RUNE Price USD',
                                    child: SelectableText(
                                        "\$${NumberFormat.currency(
                                      symbol: "",
                                      decimalDigits: 2,
                                    ).format(double.parse(data.runePriceUSD))}")),
                                StatItem(
                                    label: 'RUNE Depth',
                                    child: ValueWithUsd(
                                        value: (int.parse(data.runeDepth) /
                                                pow(10, 8))
                                            .ceil()))
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
                                    label: '24h Swap Count',
                                    child: SelectableText(f.format(
                                        int.tryParse(data.swapCount24h) ?? 0))),
                                StatItem(
                                    label: '30d Swap Count',
                                    child: SelectableText(f.format(
                                        int.tryParse(data.swapCount30d) ?? 0))),
                                StatItem(
                                    label: 'Total Swap Count',
                                    child: SelectableText(f.format(
                                        int.tryParse(data.swapCount) ?? 0))),
                              ],
                            ),
                          ),
                          Container(
                            decoration: rowDecoration,
                            padding: rowPadding,
                            child: Row(
                              children: [
                                StatItem(
                                    label: 'Unique Swapper Count',
                                    child: SelectableText(f.format(
                                        int.tryParse(data.uniqueSwapperCount) ??
                                            0))),
                                StatItem(
                                    label: 'Swap To Asset Count',
                                    child: SelectableText(f.format(
                                        int.tryParse(data.toAssetCount) ?? 0))),
                                StatItem(
                                    label: 'Swap To RUNE Count',
                                    child: SelectableText(f.format(
                                        int.tryParse(data.toRuneCount) ?? 0))),
                              ],
                            ),
                          ),
                          Container(
                            decoration: rowDecoration,
                            padding: rowPadding,
                            child: Row(
                              children: [
                                StatItem(
                                    width: 225,
                                    label: 'Swap Volume',
                                    child: ValueWithUsd(
                                        value: (int.parse(data.swapVolume) /
                                                pow(10, 8))
                                            .ceil())),
                                StatItem(
                                    width: 225,
                                    label: 'Switched RUNE',
                                    child: ValueWithUsd(
                                        value: (int.parse(data.switchedRune) /
                                                pow(10, 8))
                                            .ceil())),
                              ],
                            ),
                          ),
                          Container(
                              decoration: rowDecoration,
                              padding: rowPadding,
                              child: Row(children: [
                                StatItem(
                                    width: 225,
                                    label: 'Add Liquidity Volume',
                                    child: ValueWithUsd(
                                        value: (int.parse(
                                                    data.addLiquidityVolume) /
                                                pow(10, 8))
                                            .ceil())),
                                StatItem(
                                    label: 'Add Liquidity Count',
                                    child: SelectableText(f.format(
                                        int.tryParse(data.addLiquidityCount) ??
                                            0))),
                              ])),
                          Container(
                              decoration: rowDecoration,
                              padding: rowPadding,
                              child: Row(children: [
                                StatItem(
                                    width: 225,
                                    label: 'Withdraw Volume',
                                    child: ValueWithUsd(
                                        value: (int.parse(data.withdrawVolume) /
                                                pow(10, 8))
                                            .ceil())),
                                StatItem(
                                    label: 'Withdraw Count',
                                    child: SelectableText(f.format(
                                        int.tryParse(data.withdrawCount) ??
                                            0))),
                              ])),
                          Container(
                              decoration: rowDecoration,
                              padding: rowPadding,
                              child: Row(children: [
                                StatItem(
                                    width: 225,
                                    label: 'Impermanent Loss Protection Paid',
                                    child: ValueWithUsd(
                                        value: (int.parse(data
                                                    .impermanentLossProtectionPaid) /
                                                pow(10, 8))
                                            .ceil())),
                              ]))
                        ],
                      )),
                ),
              ],
            ));
  }
}
