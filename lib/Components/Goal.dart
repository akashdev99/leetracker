import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import 'package:leetrack/Components/WidgetContainer.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:intl/intl.dart';

class Goal extends StatelessWidget {
  final String? Title;
  final bool? Health;
  final DateTime? DueDate;
  final List<bool>? Weekdays;
  //[1,1,0,0,0,1,1] = [SUN , MON , TUE , WED , THU ,  FRI , SAT ]

  List<Widget> getWeekdaysActive(List<bool> Weekdays, BuildContext context) {
    List<Widget> body = [];
    List<String> weekdayString = ["S ", "M ", "T ", "W ", "T ", "F ", "S "];
    Weekdays.asMap().forEach((index, element) {
      body.add(
        Text(weekdayString[index],
            style: element
                ? TextStyle(color: Colors.purple)
                : Theme.of(context).textTheme.bodyText1),
      );
    });
    return body;
  }

  final String? Streak;
  const Goal({
    Key? key,
    @required this.Title,
    @required this.Health,
    @required this.DueDate,
    @required this.Weekdays,
    @required this.Streak,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetContainer(
        Title: Title,
        Height: 150.0,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat('yyyy-MM-dd').format(DueDate!),
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 50),
                Row(
                  children: getWeekdaysActive(Weekdays!, context),
                )
              ],
            ),
            Expanded(
                child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.local_fire_department,
                size: 100,
                color: (Health!) ? Colors.amber : Colors.blueGrey,
              ),
            )),
          ],
        ));
  }
}
