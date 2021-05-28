import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_classes/pool_volume_history.dart';
import 'package:thorchain_explorer/_classes/tc_network.dart';
import 'package:thorchain_explorer/_enums/page_options.dart';
import 'package:thorchain_explorer/_gql_queries/gql_queries.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/error_display.dart';
import 'package:thorchain_explorer/_widgets/tc_scaffold.dart';
import 'package:thorchain_explorer/dashboard/network_widget.dart';
import 'package:thorchain_explorer/dashboard/stats_widget.dart';
import 'package:thorchain_explorer/_widgets/volume_chart.dart';

class DashboardPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateTime startDate = currentDate.subtract(Duration(days: 14));
    final stats = useProvider(statsProvider);

    return TCScaffold(
        currentArea: PageOptions.Dashboard,
        child: Query(
            options: dashboardQueryOptions(startDate, currentDate),
            // Just like in apollo refetch() could be used to manually trigger a refetch
            // while fetchMore() can be used for pagination purpose
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result.hasException) {
                print(result.exception.toString());
                return Center(
                    child: ErrorDisplay(
                  subHeader:
                      'There has been an error fetching Dashboard data from the Midgard API.',
                  instructions: [
                    '1) Please try again later.',
                    '2) If error persists, please file an issue at https://github.com/asgardex/thorchain_explorer/issues.'
                  ],
                ));
              }

              if (result.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              TCNetwork network = TCNetwork.fromJson(result.data?['network']);
              PoolVolumeHistory volumeHistory =
                  PoolVolumeHistory.fromJson(result.data?['volumeHistory']);

              return LayoutBuilder(builder: (context, constraints) {
                return Column(
                  children: [
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
                    constraints.maxWidth < 900
                        ? Container(
                            child: Column(
                              children: [
                                StatsWidget(stats),
                                SizedBox(
                                  height: 32,
                                ),
                                NetworkWidget(network),
                              ],
                            ),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: StatsWidget(stats),
                              ),
                              SizedBox(
                                width: 32,
                              ),
                              Expanded(
                                child: NetworkWidget(network),
                              )
                            ],
                          )
                  ],
                );
              });
            }));
  }
}
