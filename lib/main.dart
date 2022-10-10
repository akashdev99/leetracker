import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import 'package:leetrack/widgets/CodeActivity.dart';
import 'package:leetrack/Components/WidgetContainer.dart';
import 'package:leetrack/widgets/SolvedProblems.dart';
import 'package:leetrack/Components/ScaffoldBase.dart';
import 'package:leetrack/views/SubmissionPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeetTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'LeetTracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldBase(title: widget.title, childPadding: 8, child: <Widget>[
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
      )
    ]);
  }
}


// https://www.material.io/components/bottom-navigation/flutter#bottom-navigation-example -> Bottom Nav