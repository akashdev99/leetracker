import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'dart:convert';
import 'package:leetrack/views/SubmissionPage.dart';

import 'package:http/http.dart' as http;

Future<dynamic> fetchActiveDates() async {
  Map<String, String> jsonMap = {
    "query":
        "\n    query userProfileCalendar(\$username: String!, \$year: Int) {\n  matchedUser(username: \$username) {\n    userCalendar(year: \$year) {\n      activeYears\n      streak\n      totalActiveDays\n      dccBadges {\n        timestamp\n        badge {\n          name\n          icon\n        }\n      }\n      submissionCalendar\n    }\n  }\n}\n    ",
    "variables": jsonEncode({"username": "akashnandan99"})
  };

  Map<String, String> header = {
    "Referer": "yourReferer",
    "Content-Type": "application/json"
  };
  final response = await http.post('https://leetcode.com/graphql/',
      body: jsonEncode(jsonMap), headers: header);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Map<DateTime, int> parseDates(String datesString) {
  final quoteMatcher = RegExp(r'"(.*?)"');

  Map<String, dynamic> jsonData = jsonDecode(datesString);

  Map<DateTime, int> codeActivityMap = {};

  jsonData.forEach((date, frequency) {
    int dateUnix = int.parse(date);
    DateTime dateTimeObj = DateTime.fromMillisecondsSinceEpoch(dateUnix * 1000);
    dateTimeObj = dateTimeObj.subtract(Duration(
        hours: dateTimeObj.hour,
        minutes: dateTimeObj.minute,
        seconds: dateTimeObj.second));

    codeActivityMap[dateTimeObj] = frequency;
  });
  return codeActivityMap;
}

class CodeActivity extends StatefulWidget {
  const CodeActivity({super.key});

  @override
  State<CodeActivity> createState() => _CodeActivityState();
}

class _CodeActivityState extends State<CodeActivity> {
  late Future<dynamic> futureCalendarHeat;

  @override
  void initState() {
    super.initState();
    futureCalendarHeat = fetchActiveDates();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<dynamic>(
          future: futureCalendarHeat,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String activeDates = snapshot.data["data"]["matchedUser"]
                  ["userCalendar"]["submissionCalendar"];

              Map<DateTime, int> codeActivityMap = parseDates(activeDates);

              return HeatMap(
                datasets: codeActivityMap,
                colorMode: ColorMode.opacity,
                showText: false,
                scrollable: true,
                colorsets: const {
                  7: Colors.green,
                },
                onClick: (value) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(value.toString())));
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
