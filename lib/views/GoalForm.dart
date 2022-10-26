import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GoalForm extends StatefulWidget {
  const GoalForm({super.key});

  @override
  State<GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
            title:
                Text("New Goal", style: Theme.of(context).textTheme.headline1),
            centerTitle: false,
            backgroundColor: Theme.of(context).backgroundColor,
            foregroundColor: Colors.black,
            elevation: 0),
        body: Center(child: Text("GOals")));
  }
}
