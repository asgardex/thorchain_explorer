import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/pool.dart';
import 'package:thorchain_explorer/_classes/pool_volume_history.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_gql_queries/gql_queries.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/stat_list_item.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'package:thorchain_explorer/_widgets/volume_chart.dart';

class PoolPage extends HookWidget {
  final String asset;

  PoolPage(this.asset);

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final startDate = currentDate.subtract(Duration(days: 14));
    final cgProvider = useProvider(coinGeckoProvider);
    final ThemeMode mode = useProvider(userThemeProvider);

    final f = NumberFormat.currency(
      symbol: "",
      decimalDigits: 0,
    );

    return TCScaffold(
        currentArea: PageOptions.Pools,
        child: Query(
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final pool = Pool.fromJson(result.data?['pool']);
              final volumeHistory =
                  PoolVolumeHistory.fromJson(result.data?['volumeHistory']);

              return LayoutBuilder(builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          AssetIcon(
                            asset,
                            width: 24,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(pool.asset,
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
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
                                      child: VolumeChart(volumeHistory)),
                                )
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: VolumeChart(volumeHistory))
                              ],
                            ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Material(
                      elevation: 1,
                      borderRadius: BorderRadius.circular(4.0),
                      child: Container(
                        decoration: containerBoxDecoration(context, mode),
                        padding: EdgeInsets.all(16),
                        child: Table(
                          border: TableBorder.all(
                              width: 1, color: Theme.of(context).dividerColor),
                          children: [
                            TableRow(children: [
                              PaddedTableCell(child: Text("Status")),
                              PaddedTableCell(child: Text(pool.status)),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(child: Text("Price (in RUNE)")),
                              PaddedTableCell(
                                  child: Text("${f.format(pool.price)} RUNE")),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(child: Text("Price (in USD)")),
                              PaddedTableCell(
                                  child: Text(cgProvider.runePrice > 0
                                      ? "\$${f.format(pool.price * cgProvider.runePrice)}"
                                      : "")),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(child: Text("Units")),
                              PaddedTableCell(
                                child: Text(
                                    f.format((pool.units ?? 0) / pow(10, 8))),
                              )
                            ]),
                            TableRow(children: [
                              PaddedTableCell(child: Text("Volume 24 Hour")),
                              PaddedTableCell(
                                  child: Text(
                                      f.format(pool.volume24h / pow(10, 8)))),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(child: Text("Pool APY")),
                              PaddedTableCell(
                                  child: Text(
                                "${(pool.poolAPY * 100).toStringAsPrecision(2)}%",
                              )),
                            ]),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return constraints.maxWidth < 900
                            ? Container(
                                child: Column(
                                  children: [
                                    (pool.stakes != null)
                                        ? PoolStakesTable(pool.stakes!)
                                        : Container(),
                                    SizedBox(
                                      height: 32,
                                    ),
                                    (pool.depth != null)
                                        ? PoolDepthTable(pool.depth!)
                                        : Container(),
                                  ],
                                ),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: (pool.stakes != null)
                                        ? PoolStakesTable(pool.stakes!)
                                        : Container(),
                                  ),
                                  SizedBox(
                                    width: 32,
                                  ),
                                  Expanded(
                                    child: (pool.depth != null)
                                        ? PoolDepthTable(pool.depth!)
                                        : Container(),
                                  )
                                ],
                              );
                      },
                    )
                  ],
                );
              });
            }));
  }
}

class PoolStakesTable extends HookWidget {
  final PoolStakes poolStakes;

  final f = NumberFormat.currency(
    symbol: "",
    decimalDigits: 0,
  );

  PoolStakesTable(this.poolStakes);

  @override
  Widget build(BuildContext context) {
    final ThemeMode mode = useProvider(userThemeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Text("Asset Pool Deposited",
              style: TextStyle(color: Theme.of(context).hintColor)),
        ),
        Material(
          elevation: 1,
          child: Container(
            decoration: containerBoxDecoration(context, mode),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StatListItem(
                      label: "Asset Deposited",
                      value: f.format(poolStakes.assetStaked / pow(10, 8))),
                  StatListItem(
                      label: "RUNE Deposited",
                      value: f.format(poolStakes.runeStaked / pow(10, 8))),
                  StatListItem(
                    label: "Pool Deposited",
                    value: f.format(poolStakes.poolStaked / pow(10, 8)),
                    hideBorder: true,
                  )
                ]),
          ),
        ),
      ],
    );
  }
}

class PoolDepthTable extends HookWidget {
  final PoolDepth poolDepth;

  final f = NumberFormat.currency(
    symbol: "",
    decimalDigits: 0,
  );

  PoolDepthTable(this.poolDepth);

  @override
  Widget build(BuildContext context) {
    final ThemeMode mode = useProvider(userThemeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Text("Asset Pool Depth",
              style: TextStyle(color: Theme.of(context).hintColor)),
        ),
        Material(
            elevation: 1,
            child: Container(
              decoration: containerBoxDecoration(context, mode),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StatListItem(
                        label: "Asset Depth",
                        value: f.format(poolDepth.assetDepth / pow(10, 8))),
                    StatListItem(
                        label: "RUNE Depth",
                        value: f.format(poolDepth.runeDepth / pow(10, 8))),
                    StatListItem(
                      label: "Pool Depth",
                      value: f.format(poolDepth.poolDepth / pow(10, 8)),
                      hideBorder: true,
                    )
                  ]),
            )),
      ],
    );
  }
}

class PaddedTableCell extends StatelessWidget {
  final Widget child;

  PaddedTableCell({required this.child});

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: child,
    ));
  }
}
