import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:leetrack/widgets/LinearRange.dart';

Future<dynamic> fetchSolvedProblemStats() async {
  Map<String, String> jsonMap = {
    "query":
        "\n    query userProfileCalendar(\$username: String!, \$year: Int) {\n  matchedUser(username: \$username) {\n    userCalendar(year: \$year) {\n      activeYears\n      streak\n      totalActiveDays\n      dccBadges {\n        timestamp\n        badge {\n          name\n          icon\n        }\n      }\n      submissionCalendar\n    }\n  }\n}\n    ",
    "variables": jsonEncode({"username": "akashnandan99"})
  };

  Map<String, String> header = {
    "Referer": "yourReferer",
    "Content-Type": "application/json"
  };
  final response = await http.post('https://leetcode.com/graphql/',
      body: jsonEncode(jsonMap), headers: header);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed Solved problem Stats');
  }
}

class SolvedProblems extends StatefulWidget {
  const SolvedProblems({super.key});

  @override
  State<SolvedProblems> createState() => _SolvedProblemsState();
}

class _SolvedProblemsState extends State<SolvedProblems> {
  // late List<ChartData> data;
  late TooltipBehavior _tooltip;
  late Future<dynamic> solvedStats;

  @override
  void initState() {
    solvedStats = fetchSolvedProblemStats();

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
              direction: Axis.horizontal,
              spacing: 80,
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
