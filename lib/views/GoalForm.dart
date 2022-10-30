import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:date_field/date_field.dart';
import 'package:weekday_selector/weekday_selector.dart';

import 'package:leetrack/Database/database.dart';

class GoalForm extends StatefulWidget {
  const GoalForm({super.key});

  @override
  State<GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  final _formKey = GlobalKey<FormState>();
  int? lastTapped;
  String username = '';
  DateTime dueDate = DateTime.now();
  List<bool> weekdays = const [
    true, // Sunday
    false, // Monday
    false, // Tuesday
    false, // Wednesday
    false, // Thursday
    false, // Friday
    true, // Saturday
  ];

  List<bool> toggleWeekday(int day) {
    var index = day % 7;
    List<bool> weekdayCopy = [...weekdays];
    weekdayCopy[index] = !weekdayCopy[index];
    return weekdayCopy;
  }

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
        body: Form(
            key: _formKey,
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Task Name"),
                        onChanged: (value) => setState(() => username = value)),
                    const SizedBox(
                      height: 50,
                    ),
                    DateTimeFormField(
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.black45),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note),
                          labelText: 'Only time',
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (e) =>
                            e == null ? 'Please Choose date' : null,
                        onDateSelected: (DateTime value) =>
                            setState(() => dueDate = value)),
                    const SizedBox(
                      height: 50,
                    ),
                    WeekdaySelector(
                      // We display the last tapped value in the example app
                      onChanged: (v) {
                        setState(() => weekdays = toggleWeekday(v));
                      },
                      values: weekdays,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            DBConnection dbConnector =
                                DBConnection.getInstance();
                            var mongoConn = await dbConnector.getConnection();
                            var userCollection = mongoConn.collection("goals");
                            var goals = {
                              "title": username,
                              "dueDate": dueDate,
                              "weekdays": weekdays,
                              "streak": true,
                            };

                            await userCollection.insertAll([goals]);

                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            DBConnection dbConnector =
                                DBConnection.getInstance();
                            var mongoConn = await dbConnector.getConnection();
                            var userCollection = mongoConn.collection("goals");
                            var goals = {
                              "title": username,
                              "dueDate": dueDate,
                              "weekdays": weekdays,
                              "streak": true,
                            };

                            await userCollection
                                .remove({"title": "String Base"});
                          }
                        },
                        child: const Text('Delete'),
                      ),
                    ),
                  ],
                ))));
  }
}
