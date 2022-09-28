import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:leetrack/widgets/LinearRange.dart';

class SolvedProblems extends StatefulWidget {
  const SolvedProblems({super.key});

  @override
  State<SolvedProblems> createState() => _SolvedProblemsState();
}

class _SolvedProblemsState extends State<SolvedProblems> {
  // late List<ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    // data = [
    //   ChartData('CHN', 12),
    //   ChartData('GER', 15),
    //   ChartData('RUS', 30),
    //   ChartData('BRZ', 6.4),
    //   ChartData('IND', 14)
    // ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Container(
                child: SfCircularChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CircularSeries<ChartData, String>>[
                DoughnutSeries<ChartData, String>(
                  startAngle: 0,
                  endAngle: 360,
                  innerRadius: "90%",
                  radius: "80%",
                  dataSource: [
                    ChartData('CHN', 10, Color.fromARGB(255, 92, 86, 85)),
                    ChartData('GER', 90, Color.fromARGB(238, 123, 227, 58)),
                  ],
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Gold',
                ),
              ],
            ))),
        Expanded(
            flex: 3,
            child: Wrap(
              // crossAxisAlignment: CrossAxisAlignment.end,
              direction: Axis.horizontal, // make sure to set this
              spacing: 80, // set your spacing
              runSpacing: 20,
              children: const [
                // Expanded(
                LinearRange(
                  startRangeColor: Colors.greenAccent,
                  endRangeColor: Colors.grey,
                  rangeFirst: [0, 10],
                  rangeSecond: [10, 100],
                ),

                LinearRange(
                  startRangeColor: Colors.greenAccent,
                  endRangeColor: Colors.grey,
                  rangeFirst: [0, 10],
                  rangeSecond: [10, 100],
                ),
                LinearRange(
                  startRangeColor: Colors.greenAccent,
                  endRangeColor: Colors.grey,
                  rangeFirst: [0, 10],
                  rangeSecond: [10, 100],
                ),
                // )
              ],
            ))
        // https://help.syncfusion.com/flutter/linear-gauge/getting-started
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
