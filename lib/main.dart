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
    //Move to utility
    MaterialColor createMaterialColor(Color color) {
      List strengths = <double>[.05];
      Map<int, Color> swatch = {};
      final int r = color.red, g = color.green, b = color.blue;

      for (int i = 1; i < 10; i++) {
        strengths.add(0.1 * i);
      }
      for (var strength in strengths) {
        final double ds = 0.5 - strength;
        swatch[(strength * 1000).round()] = Color.fromRGBO(
          r + ((ds < 0 ? r : (255 - r)) * ds).round(),
          g + ((ds < 0 ? g : (255 - g)) * ds).round(),
          b + ((ds < 0 ? b : (255 - b)) * ds).round(),
          1,
        );
      }
      ;
      return MaterialColor(color.value, swatch);
    }

    MaterialColor primaryLightSwatchColor =
        createMaterialColor(Color(0xDD000000));

    return AdaptiveTheme(
      light: ThemeData(
        backgroundColor: Colors.grey.shade200,
        primarySwatch: primaryLightSwatchColor,
        cardColor: Colors.white,
        brightness: Brightness.light,

        //TextTheme
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
          headline2: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black,
          ),
          labelMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      dark: ThemeData(
          backgroundColor: Colors.grey[800],
          primarySwatch: Colors.red,
          cardColor: Colors.grey[700],
          brightness: Brightness.dark,

          //TextTheme
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
            headline2: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            ),
            labelMedium: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: Colors.white,
            ),
          )),
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
    return ScaffoldBase();
  }
}


// https://www.material.io/components/bottom-navigation/flutter#bottom-navigation-example -> Bottom Nav