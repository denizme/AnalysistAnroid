import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/StoryView.dart';
import 'package:analysist/services/get_stories.dart';
import 'package:analysist/services/get_story.dart';
import 'package:analysist/services/get_story_views.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_page_view/story_page_view.dart';

import '../../models/Stories.dart';

class StoriesController extends GetxController {
  @override
  void onInit() {
    getStories();
    super.onInit();
  }

  bool loaded = false;
  List<Stories> fetchedStories = [];
  List<Stories> myStories = [];

  markWatched(String storyId) {
    fetchedStories.where((element) => element.id == storyId).first.watched =
        true;
    update();
  }

  Future getStories([bool refresh = true]) async {
    if (refresh) {
      loaded = false;
      update();
      myStories.clear();
      myStoryViews.clear();
      fetchedStories.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? cookie = Get.find<UserController>().choosenAccount!.cookie;
    String? userId = Get.find<UserController>().choosenAccount!.cookie;
    List<String> pks =
        preferences.getStringList("storie_watchedList_$userId") ?? [];
    stories(userId, cookie).then((value) {
      loaded = true;
      for (var story in value) {
        if (Get.find<UserController>().choosenAccount!.userId ==
            story.id.toString()) {
          myStories.add(story);
        } else {
          if (pks.contains(story.id.toString())) {
            story.watched = true;
          }
          fetchedStories.add(story);
        }
      }
      update();
      getMyStoryViews();
    });
  }

  List<StoryView> myStoryViews = [];
  Future getMyStoryViews() async {
    String cookie = Get.find<UserController>().choosenAccount!.cookie;
    String csrfToken = Get.find<UserController>().choosenAccount!.csrfToken;
    if (myStories.isNotEmpty) {
      for (var story in myStories) {
        for (var item in story.items!) {
          await storyViews(item.pk.toString(), cookie, csrfToken).then((value) {
            if (value != null) {
              myStoryViews.add(value);
              update();
            }
          });
        }
      }
    }
  }

  StoryPageController storyPageController = StoryPageController(
    pagingCurve: Curves.decelerate,
    pagingDuration: const Duration(milliseconds: 700),
  );
  Stories? fetchedStory;

  Future<Stories?> getStory(dynamic reelId, [bool makeNull = false]) async {
    if (makeNull) {
      fetchedStory = null;
      update();
    }
    final completer = Completer<Stories>();
    if (fetchedStory == null) {
      String? cookie = Get.find<UserController>().choosenAccount!.cookie;
      logger.i(cookie);
      String? userId = Get.find<UserController>().choosenAccount!.userId;
      await story(userId, cookie, reelId).then((value) {
        fetchedStory = value;
        update();
        completer.complete(value);
      });
      return completer.future;
    } else {
      completer.complete(fetchedStory);
      return completer.future;
    }
  }
}
