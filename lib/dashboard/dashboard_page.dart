import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:thorchain_explorer/_classes/pool_volume_history.dart';
import 'package:thorchain_explorer/_classes/stats.dart';
import 'package:thorchain_explorer/_classes/tc_network.dart';
import 'package:thorchain_explorer/_widgets/app_bar.dart';
import 'package:thorchain_explorer/_widgets/fluid_container.dart';
import 'package:thorchain_explorer/dashboard/network_widget.dart';
import 'package:thorchain_explorer/dashboard/stats_widget.dart';
import 'package:thorchain_explorer/dashboard/volume_chart.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    print('build dash called');

    DateTime currentDate = DateTime.now();
    DateTime startDate = currentDate.subtract(Duration(days: 14));

    print((startDate.millisecondsSinceEpoch / 1000).round());
    print((currentDate.millisecondsSinceEpoch / 1000).round());


    return Scaffold(
        appBar: ExplorerAppBar(),
        // appBar: AppBar(
        //   title: Text('Network'),
        // ),
        body: Query(
          options: QueryOptions(
            document: gql("""
              query {
                network{
                  bondingAPY,
                  activeBonds,
                  activeNodeCount,
                  liquidityAPY,
                  nextChurnHeight,
                  poolActivationCountdown,
                  poolShareFactor,
                  totalReserve,
                  standbyBonds,
                  standbyNodeCount,
                  totalPooledRune
                },
                volumeHistory(
                  from:${(startDate.millisecondsSinceEpoch / 1000).round()},
                  until:${(currentDate.millisecondsSinceEpoch / 1000).round()},
                  interval:DAY,
                ){
                  meta{
                    combined{
                      count,
                      volumeInRune,
                      feesInRune
                    },
                    toRune{
                      count,
                      volumeInRune,
                      feesInRune
                    }
                    toAsset{
                      count,
                      volumeInRune,
                      feesInRune
                    }
                  },
                  intervals{
                    time,
                          combined{
                      count,
                      volumeInRune,
                      feesInRune
                    },
                    toRune{
                      count,
                      volumeInRune,
                      feesInRune
                    }
                    toAsset{
                      count,
                      volumeInRune,
                      feesInRune
                    }
                  }
                },
                stats{
                  dailyActiveUsers,
                  monthlyActiveUsers,
                  totalUsers,
                  dailyTx,
                  monthlyTx,
                  totalAssetBuys,
                  totalAssetSells,
                  totalDepth,
                  totalStakeTx,
                  totalStaked,
                  totalTx,
                  totalVolume,
                  totalWithdrawTx,
                }
              }
              """
            ), // this is the query string you just created
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
          TCNetwork network = TCNetwork.fromJson(result.data['network']);
          PoolVolumeHistory volumeHistory = PoolVolumeHistory.fromJson(result.data['volumeHistory']);
          Stats stats = Stats.fromJson(result.data['stats']);

          return
              LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                  child: FluidContainer(
                    Column(
                      children: [
                        Container(
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                child: VolumeChart(volumeHistory),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 16,),
                        constraints.maxWidth < 900
                        ? Container(
                          child: Column(
                            children: [
                              StatsWidget(stats),
                              SizedBox(height: 16,),
                              NetworkWidget(network),
                            ],
                          ),
                        )
                        : Row(
                          children: [
                            Expanded(
                              child: StatsWidget(stats),
                            ),
                            SizedBox(width: 16,),
                            Expanded(
                              child: NetworkWidget(network),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
              );
           });
        })
    );
  }
}
