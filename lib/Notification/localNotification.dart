// https://www.kodeco.com/34019063-creating-local-notifications-in-flutter
// https://github.com/MaikuB/flutter_local_notifications/blob/master/flutter_local_notifications/example/lib/main.dart/
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

Map<int, int> weeekdayMap = {
  DateTime.sunday: 0,
  DateTime.monday: 1,
  DateTime.tuesday: 2,
  DateTime.wednesday: 3,
  DateTime.thursday: 4,
  DateTime.friday: 5,
  DateTime.saturday: 6,
};

class LocalNotifcation {
  static final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> setup() async {
    // #1
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSetting = IOSInitializationSettings();

    // #2
    const initSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);

    // #3
    await _localNotificationsPlugin.initialize(initSettings).then((_) {
      print('setupPlugin: setup success');
    }).catchError((Object error) {
      print('Error: $error');
    });
  }

  static AddNotification(
      String title, String body, int endTime, String channel) async {
    // #1
    tzData.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Kolkata"));
    final scheduleTime =
        tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, endTime);

// #2
    final androidDetail = AndroidNotificationDetails(
        channel, // channel Id
        channel // channel Name
        );

    final iosDetail = IOSNotificationDetails();

    final noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );

// #3
    final id = 0;

// #4
    await _localNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduleTime,
      noticeDetail,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  static AddRepeatingNotification(
      String title, String body, List<bool> weekdays, String channel) async {
    // #1
    tzData.initializeTimeZones();

    //need to remove hard code
    //TDO : probably from settings
    tz.setLocalLocation(tz.getLocation("Asia/Kolkata"));

// #2
    final androidDetail = AndroidNotificationDetails(
        channel, // channel Id
        channel // channel Name
        );

    final iosDetail = IOSNotificationDetails();

    final noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );

// #3
    final id = 0;

    tz.TZDateTime _nextInstanceOfTenAM() {
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime scheduledDate =
          tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      return scheduledDate;
    }

    //TODO :Change to configurable time
    //TEST: does it work for each weekday
    tz.TZDateTime _nextInstanceOfClosestWeekdayTenAM() {
      tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
      int scheduledDayIndex = weeekdayMap[scheduledDate.weekday]!;

      int noOfDaysToAdd = 0;
      while (!weekdays[scheduledDayIndex % 7]) {
        noOfDaysToAdd++;
        scheduledDayIndex++;
      }
      scheduledDate = scheduledDate.add(Duration(days: noOfDaysToAdd));
      return scheduledDate;
    }

// #4
    await _localNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfClosestWeekdayTenAM(),
      noticeDetail,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      androidAllowWhileIdle: true,
    );
  }
}
