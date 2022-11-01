import 'dart:convert';
import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/FriendshipStatus.dart';

Future<FriendshipStatus?> friendShipStatus(
    String userId, String cookie, String csrfToken) async {
  var dio = Dio();
  dio.options.headers["x-ig-app-id"] = "936619743392459";
  dio.options.headers["cookie"] = cookie;
  dio.options.headers['x-csrftoken'] = csrfToken;
  String userAgent = RemoteConfigService().userAgent;
  dio.options.headers['user-agent'] = userAgent;
  try {
    var response = await dio
        .get('https://i.instagram.com/api/v1/friendships/show/$userId/');
    logger.i(response.data);
    return friendshipStatusFromJson(jsonEncode(response.data));
  } catch (e) {
    logger.e(e);

    return null;
  }
}
