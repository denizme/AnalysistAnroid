import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:analysist/models/Followings.dart';
import 'package:analysist/services/search.dart';
import 'package:analysist/ui/landing/user_controller.dart';

import 'SearchUser.dart';

class SearchController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  List<SearchUser> searchUser = [];
  searchUsers(String searchText) async {
    String? cookie = Get.find<UserController>().choosenAccount!.cookie;
    String? userId = Get.find<UserController>().choosenAccount!.cookie;
    search(userId, cookie, searchText).then((value) {
      searchUser.clear();
      searchUser = value;
      searching = false;
      update();
    });
  }

  Timer? _debounce;
  onChanged(String value) {
    searching = true;
    update();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // do something with query
      searchUsers(value);
    });
  }

  bool searching = false;
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  String text = '';
}
