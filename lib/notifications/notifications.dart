import 'package:flutter/material.dart';

import '../components.dart';
import 'utilities.dart';

class MNotificationModel {
  // singleton
  // _NotificationModel._();
  static const String expiredItems = 'expiredItems';
  static const String dateTime = 'DateTime';
  static const String iconUri = 'resource://drawable/ic_launcher.png';
  static final MNotificationModel _singleton = MNotificationModel._();
  factory MNotificationModel() {
    return _singleton;
  }
  MNotificationModel._();
  static AwesomeNotifications _notification = AwesomeNotifications();
  static AwesomeNotifications get notification => _notification;
  static void initialize() {
    _notification.initialize(iconUri, channels);
  }

  static List<NotificationChannel> get channels => [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          channelDescription: '',
        ),
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          defaultColor: Colors.teal,
          locked: true,
          importance: NotificationImportance.High,
          soundSource: 'resource://raw/res_custom_notification',
          channelDescription:
              'this is to notify you that some items have expired',
        ),
      ];
  static Future<void> createPlantFoodNotification({String? expired}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title:
            '${Emojis.food_bagel + Emojis.plant_palm_tree} Go Buy Some Food!!!',
        body: 'one time You have $expired items expired ...',
        // bigPicture: 'asset://assets/notification_map.png',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  static Future<void> createBuyReminderNotification(
      {bool itemsExpired = false,
      String? expired,
      required DateTime dateTime}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'scheduled_channel',
        title:
            '${Emojis.food_bagel + Emojis.plant_palm_tree} Go Buy Some Food!!!',
        body: 'scheduled You have $expired items expired ...',
        // bigPicture: 'asset://assets/notification_map.png',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'MARK_DONE',
          label: 'Mark Done',
        ),
      ],
      schedule: NotificationCalendar(
        //weekday: dateTime.weekday,
        hour: 16, //dateTime.hour,
        minute: 28, // dateTime.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
        allowWhileIdle: true,
      ),
    );
  }

  static void cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }

  static Future<void> calldispatcher(String id) async {
    Workmanager().executeTask((task, inputData) async {
      await MNotificationModel.createPlantFoodNotification();
      await MNotificationModel.createBuyReminderNotification(
          itemsExpired: true, expired: '2', dateTime: DateTime.now());
      return Future.value(true);
    });
  }
}
