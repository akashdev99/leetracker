import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import 'package:leetrack/widgets/CodeActivity.dart';
import 'package:leetrack/Components/WidgetContainer.dart';
import 'package:leetrack/widgets/SolvedProblems.dart';
import 'package:leetrack/Components/ScaffoldBase.dart';
import 'package:leetrack/views/SubmissionPage.dart';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  print(savedThemeMode);
  runApp(ProviderScope(child: MyApp(savedThemeMode: savedThemeMode)));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  // ignore: use_key_in_widget_constructors

  const MyApp({this.savedThemeMode});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        backgroundColor: Colors.grey.shade200,
        // brightness: Brightness.light,
        primarySwatch: Colors.blue,
        cardColor: Colors.white,
        // accentColor: Colors.amber,
        // primarySwatch: Colors.blue,
      ),
      dark: ThemeData(
          primarySwatch: Colors.red,
          backgroundColor: Colors.grey[800],
          cardColor: Colors.grey[700]),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Leet Tracker',
        theme: theme,
        darkTheme: darkTheme,
        home: const MyHomePage(title: 'LeetTracker'),
      ),
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


// https://www.material.io/components/bottom-navigation/flutter#bottom-navigation-example -> Bottom Nav