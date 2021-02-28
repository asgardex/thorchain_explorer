import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/pool.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_providers/coingecko_provider.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';

final coinGeckoProvider =
    StateNotifierProvider<CoinGeckoProvider>((ref) => CoinGeckoProvider());

class PoolsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final cgProvider = useProvider(coinGeckoProvider.state);

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
                {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<Pool> pools = List<Pool>.from(
                  result.data['pools'].map((pool) => Pool.fromJson(pool)));

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
                    children:
                        createPoolCards(context, pools, cgProvider.runePrice),
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
      String ticker = splitAssetContract[0] ?? '';
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
                    border: Border.all(color: Colors.blueGrey[800], width: 1),
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          splitAsset[0],
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                        Text(
                            "${simpleCurrency.format(pool.price * runePrice)}"),
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
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Theme.of(context).hintColor),
                              ),
                              Text(
                                "${compactCurrency.format(pool.volume24h * runePrice)}",
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
                                "${pool.poolAPY.toStringAsPrecision(2)}%",
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
