import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/pool.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'dart:math';

class PoolsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final cgProvider = useProvider(coinGeckoProvider);

    return TCScaffold(
        currentArea: PageOptions.Pools,
        child: Query(
            options: QueryOptions(
              document: gql("""
              query {
                pools{
                  asset
                  status,
                  volume24h,
                  poolAPY,
                  price
                }
              }
              """), // this is the query string you just created
              // pollInterval: Duration(seconds: 10),
            ),
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

              List<Pool> pools = List<Pool>.from(
                  result.data?['pools'].map((pool) => Pool.fromJson(pool)));
              final activePools =
                  pools.where((pool) => pool.status == 'available').toList();
              final stagedPools =
                  pools.where((pool) => pool.status == 'staged').toList();

              activePools.sort((a, b) => b.poolAPY.compareTo(a.poolAPY));

              final sortedPools = [...activePools, ...stagedPools];

              return LayoutBuilder(builder: (context, constraints) {
                return Container(
                  padding: MediaQuery.of(context).size.width < 900
                      ? EdgeInsets.all(16)
                      : EdgeInsets.zero,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 1,
                    ),
                    physics:
                        NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                    shrinkWrap: true, // You won't see infinite size error
                    children: createPoolCards(
                        context, sortedPools, cgProvider.runePrice),
                  ),
                );
              });
            }));
  }

  List<Widget> createPoolCards(
      BuildContext context, List<Pool> pools, double runePrice) {
    final compactCurrency = new NumberFormat.compactCurrency(name: "\$");
    final simpleCurrency = new NumberFormat.simpleCurrency();

    return pools.map((pool) {
      List<String> splitAsset = pool.asset.split('.');
      String tickerAndContract = splitAsset.length > 1 ? splitAsset[1] : '';
      List<String> splitAssetContract = tickerAndContract.split('-');
      String ticker = splitAssetContract[0];
      String contractAddress =
          splitAssetContract.length > 1 ? splitAssetContract[1] : '';

      return AspectRatio(
        aspectRatio: 1,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/pools/${pool.asset}'),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(4.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border:
                        Border.all(color: Colors.blueGrey.shade800, width: 1),
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AssetIcon(
                              '${splitAsset[0]}.${splitAsset[0]}',
                              width: 24,
                              iconSize: 24,
                              tooltip: splitAsset[0],
                            ),
                            SizedBox(width: 4),
                            PoolStatus(pool.status),
                          ],
                        ),
                        Text(runePrice != null
                            ? "${simpleCurrency.format(pool.price * runePrice)}"
                            : ""),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AssetIcon(
                      pool.asset,
                      iconSize: 50,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      ticker,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SelectableText(
                      contractAddress,
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "24h Volume",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).hintColor),
                              ),
                              Text(
                                runePrice != null
                                    ? "${compactCurrency.format(pool.volume24h / pow(10, 8) * runePrice)}"
                                    : "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "Pool APY",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).hintColor),
                              ),
                              Text(
                                "${(pool.poolAPY * 100).toStringAsPrecision(2)}%",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

class PoolStatus extends StatelessWidget {
  final String poolStatus;

  PoolStatus(this.poolStatus);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    double size;

    switch (poolStatus) {
      case "available":
        icon = Icons.check_circle;
        color = Colors.green.shade400;
        size = 28;
        break;

      case "suspended":
        icon = Icons.warning;
        color = Colors.red.shade400;
        size = 24;
        break;

      // staged
      default:
        icon = Icons.hourglass_empty;
        color = Colors.orange.shade400;
        size = 24;
        break;
    }

    return Tooltip(
      message: "Pool is $poolStatus",
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
