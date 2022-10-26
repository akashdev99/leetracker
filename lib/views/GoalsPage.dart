import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Align(
          alignment: Alignment.topRight,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    size: 35,
                  ),
                  label: Text("Add Goal",
                      style: Theme.of(context).textTheme.labelMedium),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  )),
                )),
          ]),
        )
      ],
    );
  }
}
