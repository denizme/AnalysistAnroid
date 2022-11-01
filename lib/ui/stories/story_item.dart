import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/models/Stories.dart';
import 'package:analysist/ui/stories/stories_controller.dart';
import 'package:analysist/ui/stories/story_view.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/ads_controller.dart';
import '../landing/user_controller.dart';

class StoryItem extends StatelessWidget {
  Stories story;
  int index;
  int length;
  StoryItem(
      {Key? key,
      required this.index,
      required this.length,
      required this.story})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              left: index != 0 ? 5 : 0, right: index == length - 1 ? 0 : 5),
          child: InkWell(
            onTap: () async {
              bool purchased = Get.find<UserController>().purchased;
              if (!purchased) {
                Get.find<AdsController>().createInterstitialAd();
              }
              print(story.id);
              Get.find<StoriesController>().getStory(story.id, true);
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              String? userId =
                  Get.find<UserController>().choosenAccount!.cookie;
              List<String> pks =
                  preferences.getStringList("storie_watchedList_$userId") ?? [];
              Get.to(
                  StoryViewPage(
                    reelId: story.id,
                    user: story.user!,
                  ),
                  duration: Duration(milliseconds: 100),
                  transition: Transition.circularReveal);
              Get.find<UserController>().changeTabOpen(false);
              Get.find<UserController>().changeHideBanner(false);
              pks.add(story.id.toString());
              preferences.setStringList("storie_watchedList_$userId", pks);
              Get.find<StoriesController>().markWatched(story.id);
            },
            borderRadius: BorderRadius.circular(50),
            child: Column(
              children: [
                OutlineGradientButton(
                  padding: EdgeInsets.all(4),
                  gradient: LinearGradient(colors: [
                    Colors.purple,
                    Colors.orange,
                  ]),
                  strokeWidth: 2,
                  radius: Radius.circular(50),
                  child: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          NetworkImage(story.user!.profilePicUrl!)),
                ),
                SizedBox(
                  height: getVerticalSize(6),
                ),
                Container(
                  width: 55,
                  child: Text(story.user!.username!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: getRegularStyle(
                          color: ColorManager.primary, fontSize: 9)),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
