import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/pool.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_gql_queries/gql_queries.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/stat_list_item.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';

class PoolPage extends HookWidget {
  final String asset;

  PoolPage(this.asset);

  @override
  Widget build(BuildContext context) {
    final cgProvider = useProvider(coinGeckoProvider.state);

    final f = NumberFormat.currency(
      symbol: "",
      decimalDigits: 0,
    );

    return TCScaffold(
        currentArea: PageOptions.Pools,
        child: Query(
            options: poolQueryOptions(asset),
            // Just like in apollo refetch() could be used to manually trigger a refetch
            // while fetchMore() can be used for pagination purpose
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

              final pool = Pool.fromJson(result.data['pool']);

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
                    Material(
                      elevation: 1,
                      borderRadius: BorderRadius.circular(4.0),
                      child: Container(
                        decoration: containerBoxDecoration(context),
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
                                  child: Text(cgProvider.runePrice != null
                                      ? "\$${f.format(pool.price * cgProvider.runePrice)}"
                                      : "")),
                            ]),
                            TableRow(children: [
                              PaddedTableCell(child: Text("Units")),
                              PaddedTableCell(
                                child: Text(f.format(pool.units / pow(10, 8))),
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
                                  child: Text("${f.format(pool.poolAPY)}%")),
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
                                    PoolStakesTable(pool.stakes),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    PoolDepthTable(pool.depth),
                                  ],
                                ),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: PoolStakesTable(pool.stakes),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: PoolDepthTable(pool.depth),
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

class PoolStakesTable extends StatelessWidget {
  final PoolStakes poolStakes;

  final f = NumberFormat.currency(
    symbol: "",
    decimalDigits: 0,
  );

  PoolStakesTable(this.poolStakes);

  @override
  Widget build(BuildContext context) {
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
            decoration: containerBoxDecoration(context),
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

class PoolDepthTable extends StatelessWidget {
  final PoolDepth poolDepth;

  final f = NumberFormat.currency(
    symbol: "",
    decimalDigits: 0,
  );

  PoolDepthTable(this.poolDepth);

  @override
  Widget build(BuildContext context) {
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
              decoration: containerBoxDecoration(context),
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

  PaddedTableCell({this.child});

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: child,
    ));
  }
}
