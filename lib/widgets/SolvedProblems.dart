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
        "\nquery userProblemsSolved(\$username: String!) {\nallQuestionsCount {\ndifficulty\n    count\n  }\n  matchedUser(username: \$username) {\n    problemsSolvedBeatsStats {\n      difficulty\n      percentage\n    }\n    submitStatsGlobal {\nacSubmissionNum {\ndifficulty\ncount\n}\n    }\n  }\n}\n    ",
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
            child: FutureBuilder<dynamic>(
                future: solvedStats,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // String activeDates = snapshot.data;
                    List<dynamic> allQuestionCount =
                        snapshot.data["data"]["allQuestionsCount"];
                    List<dynamic> problemsSolvedBeatsStats =
                        snapshot.data["data"]["matchedUser"]
                            ["problemsSolvedBeatsStats"];
                    List<dynamic> submitStats = snapshot.data["data"]
                        ["matchedUser"]["submitStatsGlobal"]["acSubmissionNum"];

                    Map<String, int> totalCountMap = {};
                    Map<String, int> submissionsCountMap = {};
                    Map<String, double> submissionsPercenttMap = {};
                    // print(submitStats);
                    submitStats.forEach((submissionObj) {
                      if (submissionObj["difficulty"] == "Easy") {
                        submissionsCountMap["Easy"] = submissionObj["count"];
                      } else if (submissionObj["difficulty"] == "Medium") {
                        submissionsCountMap["Medium"] = submissionObj["count"];
                      } else if (submissionObj["difficulty"] == "Hard") {
                        submissionsCountMap["Hard"] = submissionObj["count"];
                      }
                    });
                    print(submissionsCountMap);

                    problemsSolvedBeatsStats.forEach((submissionObj) {
                      if (submissionObj["difficulty"] == "Easy") {
                        submissionsPercenttMap["Easy"] =
                            submissionObj["percentage"];
                      } else if (submissionObj["difficulty"] == "Medium") {
                        submissionsPercenttMap["Medium"] =
                            submissionObj["percentage"];
                      } else if (submissionObj["difficulty"] == "Hard") {
                        submissionsPercenttMap["Hard"] =
                            submissionObj["percentage"];
                      }
                    });
                    print(submissionsPercenttMap);

                    allQuestionCount.forEach((submissionObj) {
                      if (submissionObj["difficulty"] == "Easy") {
                        totalCountMap["Easy"] = submissionObj["count"];
                      } else if (submissionObj["difficulty"] == "Medium") {
                        totalCountMap["Medium"] = submissionObj["count"];
                      } else if (submissionObj["difficulty"] == "Hard") {
                        totalCountMap["Hard"] = submissionObj["count"];
                      }
                    });
                    print(totalCountMap);

                    return Wrap(
                      direction: Axis.horizontal,
                      spacing: 80,
                      runSpacing: 20,
                      children: const [
                        // Expanded(

                        LinearRange(
                          startRangeColor: Colors.greenAccent,
                          endRangeColor: Colors.grey,
                          rangeFirst: [0, 10.50],
                          rangeSecond: [10.50, 100],
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
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                }))
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

class QuestionCount {
  QuestionCount(this.difficulty, this.count);
  final String difficulty;
  final int count;
}
