import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:analysist/models/Highlighted.dart';
import 'package:analysist/models/PostUser.dart';
import 'package:analysist/models/Stories.dart';
import 'package:analysist/services/get_posts.dart';
import 'package:analysist/services/highlight_stories.dart';
import 'package:analysist/services/post_stories.dart';
import 'package:analysist/ui/profile/user_profile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/constants.dart';
import '../../core/show_toast.dart';
import '../../services/get_higlighted_story.dart';
import '../../services/get_post_user.dart';
import '../landing/user_controller.dart';

class ProfileController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  void onRefresh() async {
    // monitor network fetch

    await getPostUser(user!.data.user.username!);
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await getPostUser(userName);
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadComplete();
  }

  ScrollController? controller;
  String userName = '';
  String? userId;
  PageInfo? pageInfo;
  PostUser? user;
  Future<PostUser?> getPostUser(String newUserName) async {
    userName = newUserName;
    pageInfo = null;
    String? cookie = Get.find<UserController>().choosenAccount!.cookie;
    final completer = Completer<PostUser?>();
    await postUser(userName.toString(), cookie).then((value) {
      if (value != null) {
        user = value;
        userName = user!.data.user.username!;
        userId = user!.data.user.id!;
        getUserStories(user!.data.user.id!);
        getHighlihtedStories(user!.data.user.id!);
        update();

        completer.complete(user);
      } else {
        showToast('Request Failed');
        completer.complete(null);
      }
    });
    return completer.future;
  }

  Stories? userStories;
  Highlighted? highlighted;
  Future<Stories?> getUserStories(String newUserId) async {
    userId = newUserId;
    pageInfo = null;
    String? cookie = Get.find<UserController>().choosenAccount!.cookie;
    final completer = Completer<Stories?>();
    await postStories(newUserId, cookie).then((value) {
      if (value != null) {
        userStories = value;
        update();

        completer.complete(userStories);
      } else {
        completer.complete(null);
      }
    });
    return completer.future;
  }

  List<Stories> highlightedStories = [];
  Future<Highlighted?> getHighlihtedStories(String newUserId) async {
    userId = newUserId;
    pageInfo = null;
    String? cookie = Get.find<UserController>().choosenAccount!.cookie;
    final completer = Completer<Highlighted?>();
    await higlightedStories(newUserId, cookie).then((value) {
      if (value != null) {
        highlighted = value;
        update();

        completer.complete(highlighted);
      } else {
        showToast('Request Failed');
        completer.complete(null);
      }
    });
    return completer.future;
  }

  Future<Stories?> getHighlihtedStory(String newUserId, String reelId) async {
    if (highlightedStories
        .where((element) => element.id.toString() == "highlight:$reelId")
        .isEmpty) {
      userId = newUserId;
      pageInfo = null;
      String? cookie = Get.find<UserController>().choosenAccount!.cookie;
      final completer = Completer<Stories?>();
      await highlightedStory(newUserId, cookie, reelId).then((value) {
        if (value != null) {
          highlightedStories.add(value);
          update();

          completer.complete(value);
        } else {
          showToast('Request Failed');
          completer.complete(null);
        }
      });
      return completer.future;
    } else {
      return (highlightedStories
          .where((element) => element.id.toString() == "highlight:$reelId")
          .first);
    }
  }

  Future getMorePost(String userId) async {
    String? cookie = Get.find<UserController>().choosenAccount!.cookie;

    await posts(userId, cookie, pageInfo).then((value) {
      if (value != null) {
        user!.data.user.edgeOwnerToTimelineMedia!.edges!.addAll(value.edges!);
        pageInfo = value.pageInfo;
      }
      update();
    });
  }

  @override
  void onInit() {
    controller = ScrollController(keepScrollOffset: true);
    super.onInit();
  }
}
