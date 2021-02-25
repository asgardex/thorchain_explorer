import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thorchain_explorer/_classes/pool_volume_history.dart';

class VolumeChart extends StatelessWidget {
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);

  final PoolVolumeHistory volumeHistory;

  VolumeChart(this.volumeHistory);
  final dateFormatter = DateFormat('Md');

  @override
  Widget build(BuildContext context) {
    final largestVolume =
        this.volumeHistory.intervals.fold(0, (previousValue, bucket) {
      return bucket.combined.volumeInRune > previousValue
          ? bucket.combined.volumeInRune
          : previousValue;
    });
    final divisor = 10;

    return AspectRatio(
        aspectRatio: 2,
        child: Material(
          elevation: 1,
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text("Volume"),
                ),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.center,
                      barTouchData: BarTouchData(
                        enabled: false,
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Color(0xff939393), fontSize: 10),
                          margin: 10,
                          getTitles: (double value) {
                            int i = value.toInt();

                            if (i % 2 == 0) {
                              PoolVolumeHistoryBucket bucket =
                                  volumeHistory.intervals[i];
                              DateTime date =
                                  DateTime.fromMillisecondsSinceEpoch(
                                      bucket.time * 1000);
                              return dateFormatter.format(date);
                            }

                            return "";
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Color(
                                0xff939393,
                              ),
                              fontSize: 10),
                          margin: 4,
                          interval: (((largestVolume / pow(10, 8)) ~/ divisor) *
                                  divisor) /
                              4,
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        checkToShowHorizontalLine: (value) => value % 10 == 0,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Theme.of(context).dividerColor,
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      groupsSpace: 10, // this controls width between x points
                      barGroups: getData(volumeHistory.intervals),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  List<BarChartGroupData> getData(List<PoolVolumeHistoryBucket> buckets) {
    List<BarChartGroupData> groupData = [];

    for (int i = 0; i < buckets.length; i++) {
      PoolVolumeHistoryBucket bucket = buckets[i];
      BarChartGroupData group = BarChartGroupData(
        x: i,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              y: bucket.combined.volumeInRune / pow(10, 8),
              rodStackItems: [
                BarChartRodStackItem(
                    0, bucket.toRune.volumeInRune / pow(10, 8), dark),
                BarChartRodStackItem(
                    bucket.toRune.volumeInRune / pow(10, 8),
                    (bucket.toRune.volumeInRune + bucket.toAsset.volumeInRune) /
                        pow(10, 8),
                    normal),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      );

      groupData.add(group);
    }

    return groupData;
  }
}
