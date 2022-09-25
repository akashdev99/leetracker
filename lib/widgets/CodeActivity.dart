import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

// https://pub.dev/packages/graphql_flutter -> get started here for graphql

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

Future<dynamic> fetchAlbum() async {
  Map<String, String> jsonMap = {
    "query":
        "\n    query userProblemsSolved(\$username: String!) {\n  allQuestionsCount {\n    difficulty\n    count\n  }\n  matchedUser(username: \$username) {\n    problemsSolvedBeatsStats {\n      difficulty\n      percentage\n    }\n    submitStatsGlobal {\n      acSubmissionNum {\n        difficulty\n        count\n      }\n    }\n  }\n}\n    ",
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
    print(response.statusCode);
    print(response.body);
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
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
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: FutureBuilder<dynamic>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot);
                    // print(snapshot.data!.userId);
                    // print(snapshot.data!.title);
                    return Text("Got something here");
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                })));

    //     HeatMap(
    //   datasets: {
    //     DateTime(2022, 9, 6): 3,
    //     DateTime(2022, 9, 7): 7,
    //     DateTime(2022, 9, 8): 10,
    //     DateTime(2022, 9, 9): 13,
    //     DateTime(2022, 9, 13): 6,
    //   },
    //   colorMode: ColorMode.opacity,
    //   showText: false,
    //   scrollable: true,
    //   colorsets: {
    //     1: Colors.red,
    //     3: Colors.orange,
    //     5: Colors.yellow,
    //     7: Colors.green,
    //     9: Colors.blue,
    //     11: Colors.indigo,
    //     13: Colors.purple,
    //   },
    //   onClick: (value) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text(value.toString())));
    //   },
    // ));
  }
}
