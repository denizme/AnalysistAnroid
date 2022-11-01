import 'dart:convert';
import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/User.dart';

import '../models/Followers.dart';
import '../models/Messages.dart';

Future<Messages?> messages(String userId, String cookie, limit) async {
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
        'https://i.instagram.com/api/v1/direct_v2/inbox/?persistentBadging=true&folder=0&limit=20&thread_message_limit=$limit');
    logger.i(response.data);
    return messagesFromJson(jsonEncode(response.data));
  } catch (e) {
    logger.e(e);

    return null;
  }
}
