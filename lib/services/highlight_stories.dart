import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:analysist/core/constants.dart';
import '../models/Highlighted.dart';

Future<Highlighted?> higlightedStories(String userId, String cookie) async {
  var dio = Dio();
  dio.options.headers["x-ig-app-id"] = "936619743392459";
  dio.options.headers["cookie"] = cookie;
  String userAgent = RemoteConfigService().userAgent;
  dio.options.headers['user-agent'] = userAgent;
  try {
    var response = await dio.get(
        'https://www.instagram.com/graphql/query/?query_hash=d4d88dc1500312af6f937f7b804c68c3&variables={"user_id":"$userId","include_chaining":false,"include_reel":false,"include_suggested_users":false,"include_logged_out_extras":false,"include_highlight_reels":true,"include_live_status":false}');
    return Highlighted.fromJson(response.data['data']['user']);
  } catch (e) {
    logger.e(e);
    return null;
  }
}
// 616979897

