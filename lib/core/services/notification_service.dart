import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../utils/constants.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  
  static Future<void> initialize() async {
    tz.initializeTimeZones();
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }
  
  static void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    print('Notification tapped: ${response.payload}');
  }
  
  // Schedule workout reminder
  static Future<void> scheduleWorkoutReminder({
    required int hour,
    required int minute,
    required List<int> days, // 1 = Monday, 7 = Sunday
  }) async {
    for (int day in days) {
      await _notifications.zonedSchedule(
        AppConstants.notificationWorkoutReminder + day,
        'Workout Reminder',
        'Time for your daily workout! 💪',
        _nextInstanceOfWeekday(hour, minute, day),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'workout_reminder',
            'Workout Reminders',
            channelDescription: 'Daily workout reminders',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'workout_reminder',
      );
    }
  }
  
  // Schedule water reminder
  static Future<void> scheduleWaterReminder({
    required int intervalHours,
  }) async {
    await _notifications.zonedSchedule(
      AppConstants.notificationWaterReminder,
      'Water Reminder',
      'Stay hydrated! Drink some water 💧',
      tz.TZDateTime.now(tz.local).add(Duration(hours: intervalHours)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'water_reminder',
          'Water Reminders',
          channelDescription: 'Hydration reminders',
          importance: Importance.medium,
          priority: Priority.medium,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'water_reminder',
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  
  // Schedule step goal notification
  static Future<void> scheduleStepGoalNotification({
    required int hour,
    required int minute,
  }) async {
    await _notifications.zonedSchedule(
      AppConstants.notificationStepGoal,
      'Step Goal Check',
      'Check your daily step progress! 🚶‍♂️',
      _nextInstanceOf(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'step_goal',
          'Step Goal',
          channelDescription: 'Daily step goal reminders',
          importance: Importance.medium,
          priority: Priority.medium,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'step_goal',
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  
  // Show immediate notification
  static Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'general',
          'General',
          channelDescription: 'General notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: payload,
    );
  }
  
  // Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }
  
  // Cancel specific notification
  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }
  
  // Get pending notifications
  static Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }
  
  // Helper methods for scheduling
  static tz.TZDateTime _nextInstanceOf(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    
    return scheduledDate;
  }
  
  static tz.TZDateTime _nextInstanceOfWeekday(int hour, int minute, int weekday) {
    tz.TZDateTime scheduledDate = _nextInstanceOf(hour, minute);
    
    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    
    return scheduledDate;
  }
}