import 'package:flutter/material.dart';

import 'package:leetrack/Components/ScaffoldBase.dart';
import 'package:leetrack/widgets/SubmissionList.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBase(
        title: "Submissions",
        childPadding: 8.0,
        child: <Widget>[
          const SubmissionList(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          )
        ]);
  }
}
