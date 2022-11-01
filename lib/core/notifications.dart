import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:analysist/core/initial_bindings.dart';
import 'package:path_provider/path_provider.dart';

class Notifications {
  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            playSound: true,
            styleInformation: DefaultStyleInformation(true, true));
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(presentSound: true);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  Future<void> showNotificationMediaStyle(
      String title, String body, String image) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      channelDescription: 'media channel description',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      styleInformation: const MediaStyleInformation(),
    );
    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        Random().nextInt(1000), title.trim(), body.trim(), notificationDetails);
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
