import 'dart:convert';
import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/Followings.dart';
import 'package:analysist/ui/search/SearchUser.dart';
import '../models/Followers.dart';

Future<List<SearchUser>> search(
    String userId, String cookie, String searchText) async {
  var dio = Dio();
  dio.options.headers["x-ig-app-id"] = "936619743392459";
  dio.options.headers["cookie"] = cookie;
  String userAgent = RemoteConfigService().userAgent;
  dio.options.headers['user-agent'] = userAgent;
  try {
    var response = await dio.get(
        'https://www.instagram.com/web/search/topsearch/?context=blended&query=$searchText&rank_token=0.710206134427068&include_reel=true');
    return List<SearchUser>.from(
        response.data['users'].map((x) => SearchUser.fromJson(x)));
  } catch (e) {
    logger.e(e);

    return [];
  }
}
