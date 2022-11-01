import 'dart:convert';

import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/News.dart';
import 'package:analysist/models/Stories.dart';

Future<Stories?> postStories(String userId, String cookie) async {
  var dio = Dio();
  dio.options.headers["x-ig-app-id"] = "936619743392459";
  dio.options.headers["cookie"] = cookie;
  String userAgent = RemoteConfigService().userAgent;
  dio.options.headers['user-agent'] = userAgent;

  try {
    var response = await dio.get(
        'https://i.instagram.com/api/v1/feed/reels_media/?reel_ids=$userId');
    logger.i(response.data);
    if ((response.data['reels'].isNotEmpty)) {
      return Stories.fromJson(response.data['reels'][userId]);
    } else {
      return null;
    }
  } catch (e) {
    logger.e(e);
    return null;
  }
}
// 616979897

