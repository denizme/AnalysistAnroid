import 'dart:convert';
import 'package:analysist/services/remote_config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:analysist/core/boxes.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/User.dart';
import 'package:analysist/ui/landing/user_controller.dart';

import '../core/show_toast.dart';
import '../models/Account.dart';

Future<User?> info(String userId, String cookie) async {
  var dio = Dio();

  dio.options.headers["cookie"] = cookie;
  dio.options.headers["x-ig-app-id"] = "936619743392459";
  String userAgent = RemoteConfigService().userAgent;
  logger.i(userAgent);
  dio.options.headers['user-agent'] = userAgent;
  dio.options.validateStatus = (int? status) {
    return true;
  };
  logger.i(cookie);
  logger.i(userId);
  try {
    var response =
        await dio.get('https://i.instagram.com/api/v1/users/$userId/info/');
    // if (response.data['user']['biography'] == null) {
    //   String userName = response.data['user']['username'];
    //   getDetailInfo(userName, cookie);
    // }
    logger.i(response.data['status']);
    if (response.data['message'] == 'Target user not found') {
      return null;
    } else if (response.data['spam'] == true) {
      showToast(
        "Spam",
      );
      final accountBox = Boxes.getAccounts();
      Account? account = accountBox.get(userId);
      if (account != null) {
        Get.find<UserController>().invalidToken(account);
      }
      return null;
    } else if (response.data['status'] != "ok") {
      showToast(
        "Request Failed",
      );
      final accountBox = Boxes.getAccounts();
      Account? account = accountBox.get(userId);
      if (account != null) {
        Get.find<UserController>().invalidToken(account);
      }
      return null;
    } else {
      return userFromJson(jsonEncode(response.data));
    }
  } catch (e) {
    logger.e(e);

    return null;
  }
}
