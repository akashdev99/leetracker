import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// https://pub.dev/packages/graphql_flutter -> get started here for graphql

class CodeActivity extends StatefulWidget {
  const CodeActivity({super.key});

  @override
  State<CodeActivity> createState() => _CodeActivityState();
}

class _CodeActivityState extends State<CodeActivity> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: HeatMap(
      datasets: {
        DateTime(2022, 9, 6): 3,
        DateTime(2022, 9, 7): 7,
        DateTime(2022, 9, 8): 10,
        DateTime(2022, 9, 9): 13,
        DateTime(2022, 9, 13): 6,
      },
      colorMode: ColorMode.opacity,
      showText: false,
      scrollable: true,
      colorsets: {
        1: Colors.red,
        3: Colors.orange,
        5: Colors.yellow,
        7: Colors.green,
        9: Colors.blue,
        11: Colors.indigo,
        13: Colors.purple,
      },
      onClick: (value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value.toString())));
      },
    ));
  }
}
