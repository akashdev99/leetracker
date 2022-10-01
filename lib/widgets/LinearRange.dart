import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';

class LinearRange extends StatelessWidget {
  final MaterialAccentColor? startRangeColor;
  final MaterialColor? endRangeColor;
  final List<double>? rangeFirst;
  final List<double>? rangeSecond;
  final String? completionPercent;
  final double? beatsPercent;
  final String? type;
  const LinearRange({
    Key? key,
    @required this.startRangeColor,
    @required this.endRangeColor,
    @required this.rangeFirst,
    @required this.rangeSecond,
    @required this.type,
    @required this.completionPercent,
    @required this.beatsPercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(type! + ": " + completionPercent! + "%"),
            Text("Beats :" + beatsPercent.toString())
          ],
        ),
        SfLinearGauge(
            animateRange: true,
            animationDuration: 3000,
            //do better animations  later
            ranges: [
              LinearGaugeRange(
                  startValue: rangeFirst![0],
                  endValue: rangeFirst![1],
                  color: startRangeColor),
              //Second range.
              LinearGaugeRange(
                  startValue: rangeSecond![0],
                  endValue: rangeSecond![1],
                  color: endRangeColor),
            ],
            axisTrackStyle: LinearAxisTrackStyle(thickness: 0),
            majorTickStyle: const LinearTickStyle(
                length: 0, thickness: 0, color: Colors.black),
            minorTickStyle: const LinearTickStyle(
                length: 0, thickness: 0, color: Colors.black),
            showLabels: false)
      ],
    );
  }
}
