import 'dart:convert';

import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:analysist/core/constants.dart';

import '../models/PostUser.dart';

Future<EdgeFelixCombinedDraftUploadsClass?> posts(String userId, String cookie,
    [PageInfo? pageInfo]) async {
  var dio = Dio();
  dio.options.headers["x-ig-app-id"] = "936619743392459";
  dio.options.headers["cookie"] = cookie;
  String userAgent = RemoteConfigService().userAgent;
  dio.options.headers['user-agent'] = userAgent;
  if (pageInfo == null) {
    try {
      var response = await dio.get(
          'https://www.instagram.com/graphql/query/?query_hash=69cba40317214236af40e7efa697781d&variables={"id":"$userId","first":50,"after":""}');

      return EdgeFelixCombinedDraftUploadsClass.fromJson(
          response.data['data']['user']['edge_owner_to_timeline_media']);
    } catch (e) {
      logger.e(e);
      return null;
    }
  } else {
    try {
      var response = await dio.get(
          'https://www.instagram.com/graphql/query/?query_hash=69cba40317214236af40e7efa697781d&variables={"id":"$userId","first":50,"after":"${pageInfo.endCursor}"}');

      return EdgeFelixCombinedDraftUploadsClass.fromJson(
          response.data['data']['user']['edge_owner_to_timeline_media']);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
