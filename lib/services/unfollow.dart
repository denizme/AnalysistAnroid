import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';

import '../core/constants.dart';

Future<bool> unfollow(String userId, String cookie, String csrfToken) async {
  var dio = Dio();
  dio.options.headers["x-ig-app-id"] = "936619743392459";
  dio.options.headers["cookie"] = cookie;
  dio.options.headers['x-csrftoken'] = csrfToken;
  String userAgent = RemoteConfigService().userAgent;
  dio.options.headers['user-agent'] = userAgent;
  dio.options.validateStatus = (int? status) {
    return status! < 500;
  };
  var response = await dio
      .post("https://i.instagram.com/api/v1/web/friendships/$userId/unfollow/");
  logger.i(response);
  if (response.statusCode == 302 || response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
