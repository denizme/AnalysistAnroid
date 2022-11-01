import 'dart:convert';

import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/StoryView.dart';

Future<StoryView?> storyViews(
    String reelId, String cookie, String csrfToken) async {
  var dio = Dio();
  dio.options.headers["x-ig-app-id"] = "936619743392459";
  dio.options.headers["cookie"] = cookie;
  dio.options.headers['x-csrftoken'] = csrfToken;
  String userAgent = RemoteConfigService().userAgent;
  dio.options.headers['user-agent'] = userAgent;
  try {
    var response = await dio.get(
        'https://i.instagram.com/api/v1/media/$reelId/list_reel_media_viewer/?max_id=200');
    return storyViewFromJson(jsonEncode(response.data));
  } catch (e) {
    logger.e(e);
    return null;
  }
}
