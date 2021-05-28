import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/pool_volume_history.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_gql_queries/gql_queries.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/error_display.dart';
import 'package:thorchain_explorer/_widgets/stat_item.dart';
import 'package:thorchain_explorer/_widgets/sub_navigation_item_list.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'package:thorchain_explorer/_widgets/volume_chart.dart';

class PoolPage extends HookWidget {
  final String asset;

  PoolPage(this.asset);

  @override
  Widget build(BuildContext context) {
    final List<SubNavigationItem> subNavListItems = [
      SubNavigationItem(path: '/pools/$asset', label: 'Overview', active: true),
      SubNavigationItem(path: '/pools/$asset/txs', label: 'Pool Txs'),
    ];

    return TCScaffold(
        currentArea: PageOptions.Pools,
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubNavigationItemList(subNavListItems),
              Row(
                children: [
                  AssetIcon(
                    asset,
                    width: 24,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(asset, style: Theme.of(context).textTheme.headline1),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              PoolStats(asset)
            ],
          );
        }));
  }
}

class PoolStats extends HookWidget {
  final String asset;
  final f = NumberFormat.currency(
    symbol: "",
    decimalDigits: 2,
  );
  final formatNoDecimal = NumberFormat.currency(symbol: "", decimalDigits: 0);
  final colWidth = 160.0;

  PoolStats(this.asset);

  @override
  Widget build(BuildContext context) {
    final response = useProvider(poolStatsProvider(asset));
    final ThemeMode mode = useProvider(userThemeProvider);

    return HookBuilder(
      builder: (context) {
        return response.when(
          loading: () => Padding(
            padding: const EdgeInsets.all(48),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (err, stack) {
            return ErrorDisplay(
              header: "Sorry, we're unable to find pool stats",
              subHeader: 'Please try again later',
              instructions: [
                'If error persists, please file an issue at https://github.com/asgardex/thorchain_explorer/issues.',
              ],
            );
          },
          data: (data) => Material(
            elevation: 1,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: containerBoxDecoration(context, mode),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        StatItem(
                            label: "Asset Price",
                            child: Container(
                              width: colWidth,
                              child: SelectableText(
                                  f.format(double.parse(data.assetPrice))),
                            )),
                        StatItem(
                            label: "Asset Price USD",
                            child: Container(
                              width: colWidth,
                              child: SelectableText(
                                  "\$${f.format(double.parse(data.assetPriceUSD))}"),
                            )),
                        StatItem(
                            label: "Pool APY",
                            child: Container(
                              width: colWidth,
                              child: SelectableText(
                                  "${formatNoDecimal.format(double.parse(data.poolAPY) * 100)}%"),
                            )),
                        StatItem(
                            label: "Status",
                            child: Container(
                              width: colWidth,
                              child: SelectableText(data.status),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        StatItem(
                            label: "Asset Depth",
                            child: Container(
                              width: colWidth,
                              child: SelectableText(f.format(
                                  double.parse(data.assetDepth) / pow(10, 8))),
                            )),
                        StatItem(
                            label: "RUNE Depth",
                            child: Container(
                              width: colWidth,
                              child: SelectableText(f.format(
                                  double.parse(data.runeDepth) / pow(10, 8))),
                            )),
                        StatItem(
                            label: "Units",
                            child: Container(
                              width: colWidth,
                              child: SelectableText(f.format(
                                  double.parse(data.units) / pow(10, 8))),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    PoolVolumeHistoryChart(asset),
                    Divider(),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SelectableText(
                          "Swap",
                          style: Theme.of(context).textTheme.headline2,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        StatItem(
                            label: "To Asset Fees",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(data.toAssetFees)) /
                                            pow(10, 8))
                                        .ceil()))),
                        StatItem(
                            label: "To RUNE Fees",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(data.toRuneFees)) /
                                            pow(10, 8))
                                        .ceil()))),
                        StatItem(
                            label: "Total Fees",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(data.totalFees)) /
                                            pow(10, 8))
                                        .ceil()))),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        StatItem(
                          label: "To Asset Count",
                          child: Container(
                              width: colWidth,
                              child: SelectableText(data.toAssetCount)),
                        ),
                        StatItem(
                          label: "To RUNE Count",
                          child: Container(
                              width: colWidth,
                              child: SelectableText(data.toRuneCount)),
                        ),
                        StatItem(
                          label: "Swap Count",
                          child: Container(
                              width: colWidth,
                              child: SelectableText(data.swapCount)),
                        ),
                        StatItem(
                          label: "Unique Swapper Count",
                          child: Container(
                              width: colWidth,
                              child: SelectableText(data.uniqueSwapperCount)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        StatItem(
                            label: "To Asset Volume",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(data.toAssetVolume)) /
                                            pow(10, 8))
                                        .ceil()))),
                        StatItem(
                            label: "To RUNE Volume",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(data.toRuneVolume)) /
                                            pow(10, 8))
                                        .ceil()))),
                        StatItem(
                            label: "Swap Volume",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(data.swapVolume)) /
                                            pow(10, 8))
                                        .ceil()))),
                      ],
                    ),

                    /**
                     * Commented out for now, not sure how to format these slip numbers
                     */
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // Wrap(
                    //   spacing: 16,
                    //   runSpacing: 16,
                    //   children: [
                    //     PoolStat(
                    //         label: "To Asset Average Slip",
                    //         child: Container(
                    //             width: colWidth,
                    //             child: ValueWithUsd(
                    //                 value: ((double.parse(
                    //                             data.toAssetAverageSlip)) /
                    //                         pow(10, 8))
                    //                     .ceil()))),
                    //     PoolStat(
                    //         label: "To Rune Average Slip",
                    //         child: Container(
                    //             width: colWidth,
                    //             child: ValueWithUsd(
                    //                 value: ((double.parse(
                    //                             data.toRuneAverageSlip)) /
                    //                         pow(10, 8))
                    //                     .ceil()))),
                    //     PoolStat(
                    //         label: "Average Slip",
                    //         child: Container(
                    //             width: colWidth,
                    //             child: ValueWithUsd(
                    //                 value: ((double.parse(data.averageSlip)) /
                    //                         pow(10, 8))
                    //                     .ceil()))),
                    //   ],
                    // ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SelectableText(
                          "Deposit",
                          style: Theme.of(context).textTheme.headline2,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        StatItem(
                          label: "Add Liquidity Count",
                          child: Container(
                              width: colWidth,
                              child: SelectableText(data.addLiquidityCount)),
                        ),
                        StatItem(
                          label: "Unique Member Count",
                          child: Container(
                              width: colWidth,
                              child: SelectableText(data.uniqueMemberCount)),
                        ),
                        StatItem(
                            label: "Loss Protection Paid",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(data
                                                .impermanentLossProtectionPaid) /
                                            pow(10, 8))
                                        .ceil())))),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        StatItem(
                            label: "Add Asset Liquidity Volume",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(
                                                data.addAssetLiquidityVolume)) /
                                            pow(10, 8))
                                        .ceil()))),
                        StatItem(
                            label: "Add RUNE Liquidity Volume",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(
                                                data.addRuneLiquidityVolume)) /
                                            pow(10, 8))
                                        .ceil()))),
                        StatItem(
                            label: "Add Liquidity Volume",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(
                                                data.addLiquidityVolume) /
                                            pow(10, 8))
                                        .ceil())))),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SelectableText(
                          "Withdraw",
                          style: Theme.of(context).textTheme.headline2,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        StatItem(
                          label: "Withdraw Count",
                          child: Container(
                              width: colWidth,
                              child: SelectableText(data.withdrawCount)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        StatItem(
                            label: "Withdraw Asset Volume",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(
                                                data.withdrawAssetVolume)) /
                                            pow(10, 8))
                                        .ceil()))),
                        StatItem(
                            label: "Withdraw RUNE Volume",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(
                                                data.withdrawRuneVolume)) /
                                            pow(10, 8))
                                        .ceil()))),
                        StatItem(
                            label: "Withdraw Volume",
                            child: Container(
                                width: colWidth,
                                child: ValueWithUsd(
                                    value: ((double.parse(data.withdrawVolume) /
                                            pow(10, 8))
                                        .ceil())))),
                      ],
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}

class PoolVolumeHistoryChart extends HookWidget {
  final String asset;

  PoolVolumeHistoryChart(this.asset);

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final startDate = currentDate.subtract(Duration(days: 14));

    return Query(
        options: poolQueryOptions(
            asset: asset, startDate: startDate, currentDate: currentDate),
        // Just like in apollo refetch() could be used to manually trigger a refetch
        // while fetchMore() can be used for pagination purpose
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return Container(
              height: 340,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          final volumeHistory =
              PoolVolumeHistory.fromJson(result.data?['volumeHistory']);

          return Container(
            height: 340,
            child: MediaQuery.of(context).size.width < 900
                ? ListView(
                    padding: MediaQuery.of(context).size.width < 900
                        ? EdgeInsets.symmetric(horizontal: 16)
                        : EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        child: AspectRatio(
                            aspectRatio: 2,
                            child: VolumeChart(
                              volumeHistory,
                              hideBorder: true,
                            )),
                      )
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: VolumeChart(volumeHistory, hideBorder: true))
                    ],
                  ),
          );
        });
  }
}
