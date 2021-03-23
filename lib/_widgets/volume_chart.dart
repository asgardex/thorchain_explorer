import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/pool_volume_history.dart';
import 'package:thorchain_explorer/_providers/_state.dart';

class VolumeChart extends HookWidget {
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);

  final PoolVolumeHistory volumeHistory;

  VolumeChart(this.volumeHistory);
  final dateFormatter = DateFormat('Md');

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.currency(
      symbol: "",
      decimalDigits: 0,
    );

    final cgProvider = useProvider(coinGeckoProvider.state);

    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: Colors.blueGrey[800], width: 1),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text("Volume (USD)"),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                      width: 8,
                      height: 8,
                      color: Color.fromRGBO(255, 177, 78, 1)),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 12, color: Theme.of(context).hintColor),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                      width: 8,
                      height: 8,
                      color: Color.fromRGBO(234, 95, 148, 1)),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Assets Volume",
                    style: TextStyle(
                        fontSize: 12, color: Theme.of(context).hintColor),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                      width: 8,
                      height: 8,
                      color: Color.fromRGBO(54, 176, 121, 1)),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "RUNE Volume",
                    style: TextStyle(
                        fontSize: 12, color: Theme.of(context).hintColor),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 32, 16),
                  child: LineChart(LineChartData(
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                            getTooltipItems:
                                (List<LineBarSpot> touchedBarSpots) {
                              return touchedBarSpots.map((barSpot) {
                                final flSpot = barSpot;
                                String unit;
                                switch (flSpot.barIndex) {
                                  case 2:
                                    unit = "Total";
                                    break;

                                  case 1:
                                    unit = "Assets";
                                    break;
                                  default:
                                    unit = "RUNE";
                                    break;
                                }

                                return LineTooltipItem(
                                  "\$${f.format(flSpot.y)} $unit",
                                  TextStyle(color: Colors.white),
                                );
                              }).toList();
                            }),
                        touchCallback: (LineTouchResponse touchResponse) {},
                        handleBuiltInTouches: true,
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Color(0xff939393), fontSize: 10),
                          margin: 10,
                          getTitles: (double value) {
                            PoolVolumeHistoryBucket bucket =
                                volumeHistory.intervals[value.toInt()];
                            DateTime date = DateTime.fromMillisecondsSinceEpoch(
                                bucket.time * 1000);
                            return dateFormatter.format(date);
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          // reservedSize: 32,
                          checkToShowTitle: (minValue, maxValue, sideTitles,
                              appliedInterval, value) {
                            // display every other line title
                            return (value % (appliedInterval * 2) == 0);
                          },
                          getTextStyles: (value) => const TextStyle(
                              color: Color(
                                0xff939393,
                              ),
                              fontSize: 10),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Theme.of(context).dividerColor,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      lineBarsData: buildData(
                          volumeHistory.intervals, cgProvider.runePrice)))),
            ),
          ],
        ),
      ),
    );
  }

  List<LineChartBarData> buildData(
      List<PoolVolumeHistoryBucket> buckets, double runePrice) {
    final runeVolumeLine = LineChartBarData(
      spots: buckets
          .asMap()
          .entries
          .map((e) => FlSpot(
              e.key.toDouble(),
              ((e.value.toRune.volumeInRune / pow(10, 8)) * runePrice)
                  .roundToDouble()))
          .toList(),
      isCurved: false,
      colors: [Color.fromRGBO(54, 176, 121, 1)],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData:
          BarAreaData(show: true, colors: [Color.fromRGBO(54, 176, 121, .1)]),
    );

    final assetVolumeLine = LineChartBarData(
      spots: buckets
          .asMap()
          .entries
          .map((e) => FlSpot(
              e.key.toDouble(),
              ((e.value.toAsset.volumeInRune / pow(10, 8)) * runePrice)
                  .roundToDouble()))
          .toList(),
      isCurved: false,
      colors: [
        Color.fromRGBO(234, 95, 148, 1),
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData:
          BarAreaData(show: true, colors: [Color.fromRGBO(188, 80, 144, .1)]),
    );

    final totalVolumeLine = LineChartBarData(
      spots: buckets
          .asMap()
          .entries
          .map((e) => FlSpot(
              e.key.toDouble(),
              (((e.value.toAsset.volumeInRune + e.value.toRune.volumeInRune) /
                          pow(10, 8)) *
                      runePrice)
                  .roundToDouble()))
          .toList(),
      isCurved: false,
      colors: [
        Color.fromRGBO(255, 177, 78, 1),
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: true, colors: [
        Color.fromRGBO(255, 177, 78, 0.1),
      ]),
    );

    return [runeVolumeLine, assetVolumeLine, totalVolumeLine];
  }
}
