import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import 'package:leetrack/Components/WidgetContainer.dart';

class Goal extends StatelessWidget {
  final String? Title;
  final bool? Health;
  final String? DueDate;
  //[1,1,0,0,0,1,1] = [SUN , MON , TUE , WED , THU ,  FRI , SAT ]
  final List<bool>? ActiveDays;
  final String? Streak;
  const Goal({
    Key? key,
    @required this.Title,
    @required this.Health,
    @required this.DueDate,
    @required this.ActiveDays,
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
              children: [
                Text(DueDate!, style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 50),
                Text("S M T W T F S",
                    style: Theme.of(context).textTheme.bodyText1)
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
