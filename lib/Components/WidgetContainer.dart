import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

// https://medium.com/flutter-community/beginners-guide-to-text-styling-in-flutter-3939085d6607 -> text styleing (Title)

class WidgetContainer extends StatelessWidget {
  final Widget? child;
  final String? Title;
  final double? Height;
  const WidgetContainer(
      {Key? key,
      @required this.child,
      @required this.Title,
      @required this.Height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            height: Height,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Text(
                  Title!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Expanded(child: child!),
              ],
            )));
  }
}