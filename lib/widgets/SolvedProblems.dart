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

  Map<String, int> getSubmissionCountMap(List<dynamic> submitStats) {
    Map<String, int> submissionsCountMap = {};

    submitStats.forEach((submissionObj) {
      if (submissionObj["difficulty"] == "Easy") {
        submissionsCountMap["Easy"] = submissionObj["count"];
      } else if (submissionObj["difficulty"] == "Medium") {
        submissionsCountMap["Medium"] = submissionObj["count"];
      } else if (submissionObj["difficulty"] == "Hard") {
        submissionsCountMap["Hard"] = submissionObj["count"];
      }
    });
    return submissionsCountMap;
  }

  Map<String, double> getBeatsPercent(List<dynamic> problemsSolvedBeatsStats) {
    Map<String, double> beatsPercentMap = {};

    problemsSolvedBeatsStats.forEach((submissionObj) {
      if (submissionObj["difficulty"] == "Easy") {
        beatsPercentMap["Easy"] = submissionObj["percentage"];
      } else if (submissionObj["difficulty"] == "Medium") {
        beatsPercentMap["Medium"] = submissionObj["percentage"];
      } else if (submissionObj["difficulty"] == "Hard") {
        beatsPercentMap["Hard"] = submissionObj["percentage"];
      }
    });
    return beatsPercentMap;
  }

  Map<String, int> getSubmissionCount(List<dynamic> submitStats) {
    Map<String, int> submissionsCountMap = {};

    submitStats.forEach((submissionObj) {
      if (submissionObj["difficulty"] == "Easy") {
        submissionsCountMap["Easy"] = submissionObj["count"];
      } else if (submissionObj["difficulty"] == "Medium") {
        submissionsCountMap["Medium"] = submissionObj["count"];
      } else if (submissionObj["difficulty"] == "Hard") {
        submissionsCountMap["Hard"] = submissionObj["count"];
      }
    });
    return submissionsCountMap;
  }

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

                    Map<String, int> totalCountMap =
                        getSubmissionCountMap(allQuestionCount);
                    Map<String, int> submissionsCountMap =
                        getSubmissionCount(submitStats);
                    Map<String, double> beatsPercenttMap =
                        getBeatsPercent(problemsSolvedBeatsStats);

                    double easyPercentCompletion =
                        (submissionsCountMap["Easy"]! /
                                totalCountMap["Easy"]!) *
                            100;
                    double mediumPercentCompletion =
                        (submissionsCountMap["Medium"]! /
                                totalCountMap["Medium"]!) *
                            100;
                    double hardPercentCompletion =
                        (submissionsCountMap["Hard"]! /
                                totalCountMap["Hard"]!) *
                            100;

                    return Wrap(
                      direction: Axis.horizontal,
                      spacing: 80,
                      runSpacing: 20,
                      children: [
                        LinearRange(
                          startRangeColor: Colors.greenAccent,
                          endRangeColor: Colors.grey,
                          rangeFirst: [0, easyPercentCompletion],
                          rangeSecond: [easyPercentCompletion, 100],
                          type: "Easy",
                          completionPercent:
                              easyPercentCompletion.toStringAsFixed(2),
                          beatsPercent: beatsPercenttMap["Easy"],
                        ),

                        LinearRange(
                          startRangeColor: Colors.yellowAccent,
                          endRangeColor: Colors.grey,
                          rangeFirst: [0, mediumPercentCompletion],
                          rangeSecond: [mediumPercentCompletion, 100],
                          type: "Medium",
                          completionPercent:
                              mediumPercentCompletion.toStringAsFixed(2),
                          beatsPercent: beatsPercenttMap["Medium"],
                        ),
                        LinearRange(
                          startRangeColor: Colors.redAccent,
                          endRangeColor: Colors.grey,
                          rangeFirst: [0, hardPercentCompletion],
                          rangeSecond: [hardPercentCompletion, 100],
                          type: "Hard",
                          completionPercent:
                              hardPercentCompletion.toStringAsFixed(2),
                          beatsPercent: beatsPercenttMap["Hard"],
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
