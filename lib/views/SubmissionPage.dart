import 'package:flutter/material.dart';
import 'package:leetrack/Components/WidgetContainer.dart';
import 'package:leetrack/widgets/SubmissionList.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text("Submission list"),
        ),
        body: ListView(padding: EdgeInsets.all(8),

            // title: "Submissions",
            // childPadding: 8.0,
            children: const <Widget>[
              WidgetContainer(
                Title: "Last 10 Solved",
                Height: 750.0,
                child: SubmissionList(),
              ),
            ]));
  }
}
