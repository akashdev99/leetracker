import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import 'package:leetrack/widgets/CodeActivity.dart';
import 'package:leetrack/widgets/WidgetContainer.dart';

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
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                const WidgetContainer(
                  child: const CodeActivity(),
                  Title: "Code Activity",
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const WidgetContainer(
                    child: const Text("test"),
                    Title: "Code Activity",
                  ),
                  const WidgetContainer(
                    child: const Text("test"),
                    Title: "Code Activity",
                  ),
                ],
              ),
            ])));
  }
}
