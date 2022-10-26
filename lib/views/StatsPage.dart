import 'package:flutter/material.dart';

import 'package:leetrack/widgets/CodeActivity.dart';
import 'package:leetrack/Components/WidgetContainer.dart';
import 'package:leetrack/widgets/SolvedProblems.dart';
import 'package:leetrack/views/SubmissionPage.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _MyStatsPage();
}

class _MyStatsPage extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(8), children: <Widget>[
      GestureDetector(
          //CHECK IF DOUBLE TAPOR LONG TAP
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SubmissionPage()),
            );
          },
          child: const WidgetContainer(
            Title: "Code Activity",
            Height: 300.0,
            child: CodeActivity(),
          )),
      const WidgetContainer(
        Title: "Solved Problems",
        Height: 250.0,
        child: SolvedProblems(),
      ),
      const WidgetContainer(
        Title: "Solution By Language",
        //TODOAdd Histogram grams
        Height: 250.0,
        child: Text("test"),
      ),
    ]);
  }
}
