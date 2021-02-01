import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/pool.dart';
import 'package:thorchain_explorer/_providers/coingecko_provider.dart';
import 'package:thorchain_explorer/_widgets/asset_icon.dart';

final coinGeckoProvider = StateNotifierProvider<CoinGeckoProvider>(
        (ref) => CoinGeckoProvider());

class PoolsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {

    final cgProvider = useProvider(coinGeckoProvider.state);

    return Scaffold(
        appBar: AppBar(
          title: Text('THORChain Explorer'),
        ),
        body: Query(
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
              """
              ), // this is the query string you just created
              pollInterval: Duration(seconds: 10),
            ),
            // Just like in apollo refetch() could be used to manually trigger a refetch
            // while fetchMore() can be used for pagination purpose
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return Text('Loading');
              }

              List<Pool> pools = List<Pool>.from(result.data['pools'].map((pool)=> Pool.fromJson(pool)));

              return
                LayoutBuilder(builder: (context, constraints) {
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
                          child: GridView(
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 20.0,
                              childAspectRatio: 1,
                            ),
                            physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                            shrinkWrap: true, // You won't see infinite size error
                            children: createPoolCards(context, pools, cgProvider.runePrice),
                          ),
                        ),
                      ),
                    ),
                  );
                });
            })
    );
  }

  List<Widget> createPoolCards(BuildContext context, List<Pool> pools, double runePrice) {

    final compactCurrency = new NumberFormat.compactCurrency(name: "\$");
    final simpleCurrency = new NumberFormat.simpleCurrency();

    return pools.map((pool) {

      List<String> splitAsset = pool.asset.split('.');

      return AspectRatio(
        aspectRatio: 1,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      splitAsset[0],
                      style: TextStyle(
                        color: Theme.of(context).hintColor
                      ),
                    ),
                    Text("${simpleCurrency.format(pool.price * runePrice)}"),
                  ],
                ),
                SizedBox(height: 16,),
                AssetIcon(pool.asset),
                SizedBox(height: 16,),
                Text(
                  splitAsset[1],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 16,),
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
                              color: Theme.of(context).hintColor
                            ),
                          ),
                          Text(
                            "${compactCurrency.format(pool.volume24h * runePrice)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          )
                          // Text("${pool.volume24h}"),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "Pool APY",
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Theme.of(context).hintColor
                            ),
                          ),
                          Text(
                            "${pool.poolAPY.toStringAsPrecision(2)}%",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          )
                          // Text("${pool.poolAPY}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

}


