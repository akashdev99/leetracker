import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import 'package:leetrack/widgets/CodeActivity.dart';
import 'package:leetrack/widgets/WidgetContainer.dart';
import 'package:leetrack/widgets/SolvedProblems.dart';
import 'package:leetrack/Components/ScaffoldBase.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBase(
        title: widget.title,
        childPadding: 8,
        child: const <Widget>[
          WidgetContainer(
            Title: "Code Activity",
            child: CodeActivity(),
            Height: 300.0,
          ),
          // const SolvedProblems(),
          WidgetContainer(
            Title: "Solved Problems",
            child: SolvedProblems(),
            Height: 250.0,
          ),
          WidgetContainer(
            Title: "Solution By Language",
            //TODOAdd Histogram grams
            child: Text("test"),
            Height: 250.0,
          )
        ]);
  }
}
