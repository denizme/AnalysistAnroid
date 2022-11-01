import 'package:analysist/ui/statistics.dart/best_time_for_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/statistics.dart/posts/most_commented.dart';
import 'package:analysist/ui/statistics.dart/posts/most_liked.dart';
import '../../core/boxes.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../models/Stories.dart';
import '../stories/empty_item.dart';
import '../stories/stories.dart';
import '../stories/stories_controller.dart';
import '../stories/story_item.dart';
import '../users/followers/followers.dart';
import '../users/followings/followings.dart';
import 'graphics/graphics.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cardWidget(String title, Function onTap) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onTap();
          },
          hoverColor: ColorManager.primary,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translate(title),
                      style: getMediumStyle(
                          color: ColorManager.primary, fontSize: 14),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  IconlyBold.arrow_right,
                  color: ColorManager.primary,
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget itemWidget(Color color, IconData? icon, Widget? image, String text,
        Function onTap) {
      return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300)),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 17,
                  backgroundColor: color.withOpacity(0.3),
                  child: icon == null
                      ? image
                      : Icon(
                          icon,
                          size: 18,
                          color: color.withOpacity(0.8),
                        )),
              SizedBox(
                width: getHorizontalSize(12),
              ),
              Text(
                translate(text),
                style:
                    getRegularStyle(color: ColorManager.primary, fontSize: 13),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              )
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(12)),
      child: GetBuilder<UserController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              StoriesView(),
              Divider(),
              SizedBox(
                height: getVerticalSize(5),
              ),
              Text(
                translate('Graphics'),
                style:
                    getMediumStyle(color: ColorManager.primary, fontSize: 13),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: getVerticalSize(10)),
                child: InkWell(
                  onTap: () {
                    Get.to(() => Graphics());
                    Get.find<UserController>().changeTabOpen(false);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 17,
                                backgroundColor: Colors.brown.withOpacity(0.3),
                                child: Icon(
                                  Icons.trending_up,
                                  size: 18,
                                  color: Colors.brown.withOpacity(0.8),
                                )),
                            SizedBox(
                              width: getHorizontalSize(12),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translate('Statistics'),
                                  style: getBoldStyle(
                                      color: ColorManager.primary,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: getVerticalSize(3),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      translate('View this weeks data reports'),
                                      style: getRegularStyle(
                                          color: ColorManager.primary,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: getVerticalSize(5),
              ),
              Text(
                translate('Post Analysis'),
                style:
                    getMediumStyle(color: ColorManager.primary, fontSize: 13),
              ),
              SizedBox(
                height: getVerticalSize(5),
              ),
              itemWidget(Colors.pink, Icons.favorite, null, "Most Likes", () {
                Get.to(() => MostLiked(), transition: Transition.rightToLeft);
                Get.find<UserController>().changeTabOpen(false);
              }),
              itemWidget(Colors.blue, Icons.comment, null, "Most Comments", () {
                Get.to(() => MostCommented(),
                    transition: Transition.rightToLeft);
                Get.find<UserController>().changeTabOpen(false);
              }),
              itemWidget(Colors.orangeAccent, Icons.all_inbox, null,
                  "Most Comments and Likes", () {
                Get.to(() => MostCommented(),
                    transition: Transition.rightToLeft);
                Get.find<UserController>().changeTabOpen(false);
              }),
              SizedBox(
                height: getVerticalSize(5),
              ),
              Text(
                translate('Follower Analytics'),
                style:
                    getMediumStyle(color: ColorManager.primary, fontSize: 13),
              ),
              SizedBox(
                height: getVerticalSize(5),
              ),
              itemWidget(Colors.cyan, CupertinoIcons.person_crop_square, null,
                  "Newest Followers", () {
                Get.to(
                    FollowersView(
                      followers: Boxes.getFollowers()
                          .values
                          .toList()
                          .where((element) =>
                              element.userIdForAccount != null &&
                              element.userIdForAccount ==
                                  controller.choosenAccount!.userId &&
                              DateTime.now()
                                      .difference(element.timestamp)
                                      .inHours <
                                  24 &&
                              element.stillFollower &&
                              !controller.firstFollowersIds
                                  .contains(element.pk.toString()))
                          .toList(),
                      title: translate('Newest Followers'),
                    ),
                    transition: Transition.rightToLeftWithFade);
                Get.find<UserController>().changeTabOpen(false);
              }),
              itemWidget(Colors.blue, CupertinoIcons.minus_square, null,
                  "Lost Followers", () {
                Get.to(
                    FollowersView(
                      followers: Boxes.getFollowers()
                          .values
                          .toList()
                          .where((element) =>
                              element.userIdForAccount != null &&
                              element.userIdForAccount ==
                                  controller.choosenAccount!.userId &&
                              DateTime.now()
                                      .difference(element.timestamp)
                                      .inHours <
                                  24 &&
                              !element.stillFollower)
                          .toList(),
                      title: translate("Lost Followers"),
                    ),
                    transition: Transition.rightToLeftWithFade);
                Get.find<UserController>().changeTabOpen(false);
              }),
              itemWidget(
                  Colors.red,
                  null,
                  Image.asset(
                    'assets/images/broken_heart.png',
                    width: 18,
                    height: 18,
                    color: Colors.red,
                  ),
                  "Users I have Unfollowed", () {
                Get.to(
                    FollowingsView(
                      followings: Boxes.getFollowings()
                          .values
                          .toList()
                          .where((element) =>
                              element.userIdForAccount != null &&
                              element.userIdForAccount ==
                                  controller.choosenAccount!.userId &&
                              DateTime.now()
                                      .difference(element.timestamp)
                                      .inHours <
                                  24 &&
                              !element.stillFollowing)
                          .toList(),
                      title: translate(
                        'Users I have Unfollowed',
                      ),
                    ),
                    transition: Transition.rightToLeftWithFade);
                Get.find<UserController>().changeTabOpen(false);
              }),
              SizedBox(
                height: getVerticalSize(5),
              ),
              Text(
                translate('Best Time to Share'),
                style:
                    getMediumStyle(color: ColorManager.primary, fontSize: 13),
              ),
              SizedBox(
                height: getVerticalSize(5),
              ),
              InkWell(
                onTap: () {
                  Get.to(BestTimeForPosts(),
                      transition: Transition.rightToLeft);
                  Get.find<UserController>().changeTabOpen(false);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.green.withOpacity(0.3),
                          child: Icon(
                            Icons.timer_outlined,
                            size: 18,
                            color: Colors.green.withOpacity(0.8),
                          )),
                      SizedBox(
                        width: getHorizontalSize(12),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translate("13:00 - 14:00"),
                            style: getMediumStyle(
                                color: ColorManager.primary, fontSize: 14),
                          ),
                          Text(
                            translate("Best Time to Post"),
                            style: getRegularStyle(
                                color: ColorManager.primary, fontSize: 11),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
