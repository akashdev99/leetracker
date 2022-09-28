import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
              children: [
                // Expanded(
                SfLinearGauge(
                    animateRange: true,
                    animationDuration: 3000,
                    //do better animations  later
                    ranges: const [
                      LinearGaugeRange(
                          startValue: 0,
                          endValue: 50,
                          color: Colors.blueAccent),
                      //Second range.
                      LinearGaugeRange(
                          startValue: 50,
                          endValue: 100,
                          color: Colors.redAccent),
                    ],
                    axisTrackStyle: LinearAxisTrackStyle(thickness: 0),
                    majorTickStyle: const LinearTickStyle(
                        length: 0, thickness: 0, color: Colors.black),
                    minorTickStyle: const LinearTickStyle(
                        length: 0, thickness: 0, color: Colors.black),
                    showLabels: false),
                // ),
                // Expanded(
                SfLinearGauge(
                    animateRange: true,
                    animationDuration: 3000,
                    ranges: const [
                      LinearGaugeRange(
                          startValue: 0,
                          endValue: 50,
                          color: Colors.blueAccent),
                      //Second range.
                      LinearGaugeRange(
                          startValue: 50, endValue: 100, color: Colors.green),
                    ],
                    axisTrackStyle: LinearAxisTrackStyle(thickness: 0),
                    majorTickStyle: const LinearTickStyle(
                        length: 0, thickness: 0, color: Colors.black),
                    minorTickStyle: const LinearTickStyle(
                        length: 0, thickness: 0, color: Colors.black),
                    showLabels: false),
                // ),
                // Expanded(
                // child:
                SfLinearGauge(
                    animateRange: true,
                    animationDuration: 3000,
                    ranges: const [
                      LinearGaugeRange(
                          startValue: 0,
                          endValue: 50,
                          color: Colors.blueAccent),
                      //Second range.
                      LinearGaugeRange(
                          startValue: 50, endValue: 100, color: Colors.yellow),
                    ],
                    axisTrackStyle: LinearAxisTrackStyle(thickness: 0),
                    majorTickStyle: const LinearTickStyle(
                        length: 0, thickness: 0, color: Colors.black),
                    minorTickStyle: const LinearTickStyle(
                        length: 0, thickness: 0, color: Colors.black),
                    showLabels: false),
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
