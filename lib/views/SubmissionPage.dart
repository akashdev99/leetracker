import 'package:flutter/material.dart';
import 'package:leetrack/Components/WidgetContainer.dart';
import 'package:leetrack/Components/ScaffoldBase.dart';
import 'package:leetrack/widgets/SubmissionList.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldBase(
        title: "Submissions",
        childPadding: 8.0,
        child: <Widget>[
          WidgetContainer(
            Title: "Code Activity",
            child: SubmissionList(),
            Height: 650.0,
          ),
        ]);
  }
}
