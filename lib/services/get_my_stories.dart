import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/Stories.dart';

Future<Stories?> myStories(
  String userId,
  String cookie,
) async {
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
        'https://i.instagram.com/api/v1/feed/reels_media/?reel_ids=$userId');
    return Stories.fromJson(response.data['reels'][userId]);
  } catch (e) {
    logger.e(e);

    return null;
  }
}
