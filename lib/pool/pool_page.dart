import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/pool.dart';
import 'package:thorchain_explorer/_gql_queries/gql_queries.dart';
import 'package:thorchain_explorer/_providers/coingecko_provider.dart';
import 'package:thorchain_explorer/_widgets/app_bar.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';
import 'package:thorchain_explorer/_widgets/stat_list_item.dart';

final coinGeckoProvider =
StateNotifierProvider<CoinGeckoProvider>((ref) => CoinGeckoProvider());

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

    return Scaffold(
        appBar: ExplorerAppBar(),
        body: Query(
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

            // List<Pool> pools = Pool.from(
            //     result.data['pools'].map((pool) => Pool.fromJson(pool)));
            final pool = Pool.fromJson(result.data['pool']);

            return LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  padding: constraints.maxWidth < 500
                      ? EdgeInsets.zero
                      : EdgeInsets.all(30.0),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 25.0),
                      constraints: BoxConstraints(
                        maxWidth: 1024,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AssetIcon(asset, width: 24,),
                              SizedBox(width: 8,),
                              Text(
                                  pool.asset,
                                  style: Theme.of(context).textTheme.headline6
                              ),
                            ],
                          ),
                          SizedBox(height: 16,),
                          Material(
                            elevation: 4,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Table(
                                border: TableBorder.all(width: 1, color: Theme.of(context).dividerColor),
                                children: [
                                  TableRow(
                                    children: [
                                      PaddedTableCell(child: Text("Status")),
                                      PaddedTableCell(child: Text(pool.status)),
                                    ]
                                  ),
                                  TableRow(
                                      children: [
                                        PaddedTableCell(child: Text("Price (in RUNE)")),
                                        PaddedTableCell(child: Text(
                                            "${f.format(pool.price)} RUNE"
                                        )),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        PaddedTableCell(child: Text("Price (in USD)")),
                                        PaddedTableCell(child: Text(
                                            "\$${f.format(pool.price * cgProvider.runePrice)}"
                                        )),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        PaddedTableCell(child: Text("Units")),
                                        PaddedTableCell(child: Text(f.format(pool.units / pow(10, 8))),)
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        PaddedTableCell(child: Text("Volume 24 Hour")),
                                        PaddedTableCell(child: Text(f.format(pool.volume24h / pow(10, 8)))),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        PaddedTableCell(child: Text("Pool APY")),
                                        PaddedTableCell(child: Text("${f.format(pool.poolAPY)}%")),
                                      ]
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16,),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return constraints.maxWidth < 900
                                ? Container(
                                    child: Column(
                                      children: [
                                        PoolStakesTable(pool.stakes),
                                        SizedBox(height: 16,),
                                        PoolDepthTable(pool.depth),
                                      ],
                                    ),
                                  )
                                : Row(
                                  children: [
                                    Expanded(
                                      child: PoolStakesTable(pool.stakes),
                                    ),
                                    SizedBox(width: 16,),
                                    Expanded(
                                      child: PoolDepthTable(pool.depth),
                                    )
                                  ],
                                );
                            },
                          )
                        ],
                      )
                    ),
                  ),
                ),
              );
            });
          })
    );
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
    return Material(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text("Asset Pool Deposited"),
              decoration: BoxDecoration(
                border: Border(
                bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor)
                )
              ),
            ),
            StatListItem(label: "Asset Staked", value: f.format(poolStakes.assetStaked / pow(10, 8))),
            StatListItem(label: "RUNE Staked", value: f.format(poolStakes.runeStaked / pow(10, 8))),
            StatListItem(label: "Pool Staked", value: f.format(poolStakes.poolStaked / pow(10, 8)), hideBorder: true,)
          ]
        )
      )
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
    return Material(
        elevation: 4,
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text("Asset Pool Depth"),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor)
                        )
                    ),
                  ),
                  StatListItem(label: "Asset Depth", value: f.format(poolDepth.assetDepth / pow(10, 8))),
                  StatListItem(label: "RUNE Depth", value: f.format(poolDepth.runeDepth / pow(10, 8))),
                  StatListItem(label: "Pool Depth", value: f.format(poolDepth.poolDepth / pow(10, 8)), hideBorder: true,)
                ]
            )
        )
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
      )
    );
  }
}
