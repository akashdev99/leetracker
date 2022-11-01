import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:leetrack/views/GoalForm.dart';
import 'package:leetrack/Components/WidgetContainer.dart';
import 'package:leetrack/Components/Goal.dart';

import 'package:leetrack/Database/database.dart';

Future<dynamic> fetchGoals() async {
  DBConnection dbConnector = DBConnection.getInstance();
  var mongoConn = await dbConnector.getConnection();
  var userCollection = mongoConn.collection("goals");
  // await userCollection.remove({'dueDate': '12th noc'});
  return await userCollection.find().toList();
}

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  // late Future<dynamic> futureGoals;
  dynamic goals;
  @override
  void initState() {
    super.initState();
    // futureGoals = fetchGoals();
    fetchGoals().then((value) {
      setState(() => goals = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (goals != null) {
      List<Widget> goalList = [];

      goals.forEach((goal) {
        List<bool> weekdays =
            (goal["weekdays"] as List).map((item) => item as bool).toList();
        goalList.add(Goal(
          Title: goal["title"],
          DueDate: goal["dueDate"],
          Weekdays: weekdays,
          Health: goal["streak"],
        ));
      });

      return ListView(
        padding: const EdgeInsets.all(8),
        children: [
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topRight,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child: TextButton.icon(
                    onPressed: () {
                      var data = Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GoalForm()),
                      ).then((dynamic value) {
                        fetchGoals().then((value) {
                          setState(() => goals = value);
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 35,
                    ),
                    label: Text("Add Goal",
                        style: Theme.of(context).textTheme.labelMedium),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    )),
                  )),
            ]),
          ),
          SizedBox(height: 20),
          ...goalList,
        ],
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
