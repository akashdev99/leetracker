import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

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
    // print(response.statusCode);
    // print(response.body);
    return jsonDecode(response.body);
  } else {
    print(response.statusCode);
    print(response.body);
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

List<DateTime> parseDates(String datesString) {
  final quoteMatcher = RegExp(r'"(.*?)"');

  Iterable<RegExpMatch> matches = quoteMatcher.allMatches(datesString);
  List<DateTime> dateTimeList = [];
  for (final match in matches) {
    int dateUnix = int.parse(match[0]!.substring(1, match[0]!.length - 1));

    DateTime dateTimeObj = DateTime.fromMillisecondsSinceEpoch(dateUnix * 1000);
    dateTimeObj = dateTimeObj.subtract(Duration(
        hours: dateTimeObj.hour,
        minutes: dateTimeObj.minute,
        seconds: dateTimeObj.second));

    dateTimeList.add(dateTimeObj);
  }
  return dateTimeList;
}

class CodeActivity extends StatefulWidget {
  const CodeActivity({super.key});

  @override
  State<CodeActivity> createState() => _CodeActivityState();
}

class _CodeActivityState extends State<CodeActivity> {
  late Future<dynamic> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchActiveDates();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: FutureBuilder<dynamic>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // print(snapshot.data!.userId);
                    String activeDates = snapshot.data["data"]["matchedUser"]
                        ["userCalendar"]["submissionCalendar"];

                    List<DateTime> dateTimeList = parseDates(activeDates);
                    Map<DateTime, int> activityFrequencyMap = {};

                    dateTimeList.forEach(
                        (dateTime) => {activityFrequencyMap[dateTime] = 3});

                    print(activityFrequencyMap);
                    return HeatMap(
                      datasets: activityFrequencyMap,
                      colorMode: ColorMode.opacity,
                      showText: false,
                      scrollable: true,
                      colorsets: {
                        // 1: Colors.red,
                        // 3: Colors.orange,
                        // 5: Colors.yellow,
                        7: Colors.green,
                        // 9: Colors.blue,
                        // 11: Colors.indigo,
                        // 13: Colors.purple,
                      },
                      onClick: (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(value.toString())));
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                })));
  }
}
