import 'dart:convert';
import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/User.dart';

import '../models/Followers.dart';

Future<Followers?> getFollowers(String userId, String cookie,
    [String maxId = '']) async {
  var dio = Dio();
  dio.options.headers["x-ig-app-id"] = "936619743392459";
  dio.options.headers["cookie"] = cookie;
  String userAgent = RemoteConfigService().userAgent;
  dio.options.headers['user-agent'] = userAgent;
  try {
    var response = await dio.get(
        'https://i.instagram.com/api/v1/friendships/$userId/followers?max_id=$maxId');
    return followersFromJson(jsonEncode(response.data));
  } catch (e) {
    logger.e(e);

    return null;
  }
}
