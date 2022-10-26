import 'package:flutter/material.dart';

import 'package:leetrack/widgets/CodeActivity.dart';
import 'package:leetrack/Components/WidgetContainer.dart';
import 'package:leetrack/widgets/SolvedProblems.dart';
import 'package:leetrack/Components/ScaffoldBase.dart';
import 'package:leetrack/views/SubmissionPage.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _MyStatsPage();
}

class _MyStatsPage extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(8), children: <Widget>[
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
            child: CodeActivity(),
            Height: 250.0,
          )),
      const WidgetContainer(
        Title: "Solved Problems",
        child: SolvedProblems(),
        Height: 250.0,
      ),
      const WidgetContainer(
        Title: "Solution By Language",
        //TODOAdd Histogram grams
        child: Text("test"),
        Height: 250.0,
      ),

      //TODO: remove - test code
      // https://blog.logrocket.com/theming-your-app-flutter-guide/
      Center(
        child: RawMaterialButton(
          child: const Text(
            'Switch Modes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            AdaptiveTheme.of(context).toggleThemeMode();
          },
          fillColor: Colors.green,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    ]);
  }
}
