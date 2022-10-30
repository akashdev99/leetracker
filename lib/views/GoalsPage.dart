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
  late Future<dynamic> futureGoals;
  @override
  void initState() {
    super.initState();
    futureGoals = fetchGoals();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: futureGoals,
        builder: (context, snapshot) {
          List<Widget> goalList = [];
          if (snapshot.hasData) {
            snapshot.data.forEach((goal) {
              print(goal);
              List<bool> weekdays = (goal["weekdays"] as List)
                  .map((item) => item as bool)
                  .toList();
              goalList.add(Goal(
                Title: goal["title"],
                DueDate: goal["dueDate"],
                Weekdays: weekdays,
                Health: true,
              ));
            });

            return ListView(
              padding: const EdgeInsets.all(8),
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topRight,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GoalForm()),
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 35,
                          ),
                          label: Text("Add Goal",
                              style: Theme.of(context).textTheme.labelMedium),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
          }
          return const CircularProgressIndicator();
        });
  }
}
