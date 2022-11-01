import 'dart:convert';

import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/Stories.dart';

Future<List<Stories>> stories(String userId, String cookie) async {
  var dio = Dio();
  dio.options.headers["x-ig-app-id"] = "936619743392459";
  dio.options.headers["cookie"] = cookie;
  String userAgent = RemoteConfigService().userAgent;
  dio.options.headers['user-agent'] = userAgent;
  try {
    var response =
        await dio.get('https://i.instagram.com/api/v1/feed/reels_tray/');
    return storiesFromJson(jsonEncode(response.data['tray']));
  } catch (e) {
    logger.e(e);
    return [];
  }
}
