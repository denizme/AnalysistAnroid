import 'dart:convert';

import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/PostUser.dart';

Future<PostUser?> postUser(String userName, String cookie) async {
  logger.i(userName);

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
        'https://i.instagram.com/api/v1/users/web_profile_info/?username=$userName');

    if (response.data['data']['user'] != null) {
      return postUserFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  } catch (e) {
    logger.e(e);
    return null;
  }
}
