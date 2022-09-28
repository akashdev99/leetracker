import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import 'package:leetrack/widgets/CodeActivity.dart';
import 'package:leetrack/widgets/WidgetContainer.dart';
import 'package:leetrack/widgets/SolvedProblems.dart';

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
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            child: ListView(
                padding: const EdgeInsets.all(8),
                children: const <Widget>[
              WidgetContainer(
                Title: "Code Activity",
                child: CodeActivity(),
              ),
              // const SolvedProblems(),
              WidgetContainer(
                Title: "Solved Problems",
                child: SolvedProblems(),
              ),
              WidgetContainer(
                Title: "Code Activity",
                child: Text("test"),
              )
            ])));
  }
}
