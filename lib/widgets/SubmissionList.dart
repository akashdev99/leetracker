import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:leetrack/Components/WidgetContainer.dart';

Future<dynamic> fetchSubmissionList() async {
  Map<String, String> jsonMap = {
    "query":
        "\n    query recentAcSubmissions(\$username: String!, \$limit: Int!) {\n  recentAcSubmissionList(username: \$username, limit: \$limit) {\n    id\n    title\n    titleSlug\n    timestamp\n  }\n}\n    ",
    "variables": jsonEncode({"username": "akashnandan99", "limit": "10"})
  };

  Map<String, String> header = {
    "Referer": "yourReferer",
    "Content-Type": "application/json"
  };
  final response = await http.post('https://leetcode.com/graphql/',
      body: jsonEncode(jsonMap), headers: header);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}

class SubmissionList extends StatefulWidget {
  const SubmissionList({super.key});

  @override
  State<SubmissionList> createState() => _SubmissionListState();
}

class _SubmissionListState extends State<SubmissionList> {
  late Future<dynamic> futureSubmissionList;

  @override
  void initState() {
    super.initState();
    futureSubmissionList = fetchSubmissionList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<dynamic>(
            future: futureSubmissionList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> submissionList =
                    snapshot.data["data"]["recentAcSubmissionList"];

                return ListView.builder(
                    itemCount: submissionList.length,
                    itemBuilder: (context, index) {
                      final item = submissionList[index];
                      DateTime dateTimeObj =
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(item["timestamp"]) * 1000);

                      String timestamp = dateTimeObj.toString();
                      return ListTile(
                          title: Text(
                            item["title"],
                          ),
                          subtitle: Text("Completed on :" + timestamp));
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
  }
}
