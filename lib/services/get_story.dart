import 'dart:convert';
import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/Stories.dart';

Future<Stories?> story(String userId, String cookie, String reelId) async {
  var dio = Dio();
  dio.options.headers["x-ig-app-id"] = "936619743392459";
  dio.options.headers["cookie"] = cookie;
  String userAgent = RemoteConfigService().userAgent;
  dio.options.headers['user-agent'] = userAgent;
  dio.options.validateStatus = (int? status) {
    return true;
  };
  try {
    var response = await dio.get(
        'https://i.instagram.com/api/v1/feed/reels_media/?reel_ids=${reelId.toString()}');
    logger.i(response.data);
    return Stories.fromJson(response.data['reels'][reelId]);
  } catch (e) {
    logger.e(e);

    return null;
  }
}
