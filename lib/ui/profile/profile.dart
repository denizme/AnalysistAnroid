import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:analysist/core/boxes.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/models/Followers.dart';
import 'package:analysist/models/Followings.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/profile/card_view.dart';
import 'package:analysist/ui/statistics.dart/posts/all_posts.dart';
import 'package:analysist/ui/stories/stories_controller.dart';
import 'package:analysist/ui/users/followers/followers.dart';
import 'package:analysist/ui/users/followings/followings.dart';
import 'package:loading_progress_indicator/loading_progress_indicator.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_beat_progress_indicator.dart';
import '../../core/constants.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget slideWidget(int count, String text) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count.toString(),
              style: getBoldStyle(color: ColorManager.white, fontSize: 17),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              translate(text),
              style: getMediumStyle(
                  color: ColorManager.white, fontSize: 14, letterSpacing: 1.3),
            ),
          ],
        ),
      );
    }

    EdgeInsetsGeometry margin = EdgeInsets.symmetric(
        vertical: getVerticalSize(2), horizontal: getVerticalSize(5));
    Get.put(StoriesController());
    return GetBuilder<UserController>(builder: (controller) {
      return Container(
        padding: EdgeInsets.only(),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropHeader(
            waterDropColor: ColorManager.primary,
            refresh: LoadingProgressIndicator(
                indicator: BallBeatProgressIndicator(),
                size: 50,
                color: Colors.white),
            complete: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.white,
              child: Icon(Icons.check, size: 20, color: ColorManager.primary),
            ),
          ),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          child: SingleChildScrollView(
            child: ValueListenableBuilder<Box<FollowerUsers>>(
                valueListenable: Boxes.getFollowers().listenable(),
                builder: (
                  context,
                  followersBox,
                  _,
                ) {
                  return ValueListenableBuilder<Box<FollowingUsers>>(
                      valueListenable: Boxes.getFollowings().listenable(),
                      builder: (
                        context,
                        followingsBox,
                        _,
                      ) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 240,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: controller.user == null
                                    ? null
                                    : DecorationImage(
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.5),
                                            BlendMode.dstATop),
                                        image: NetworkImage(
                                          controller.user!.user.profilePicUrl,
                                        ),
                                      ),
                              ),
                              child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(30),
                                          right: getHorizontalSize(30),
                                          bottom: getVerticalSize(10)),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(
                                                    FollowersView(
                                                      followers:
                                                          controller.followers,
                                                      title: translate(
                                                          "My Followers"),
                                                    ),
                                                    transition: Transition
                                                        .rightToLeftWithFade);
                                                Get.find<UserController>()
                                                    .changeTabOpen(false);
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    translate("Followers"),
                                                    style: getMediumStyle(
                                                        color:
                                                            ColorManager.white,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(1),
                                                  ),
                                                  Text(
                                                    controller.user == null
                                                        ? "0"
                                                        : controller.user!.user
                                                            .followerCount!
                                                            .toString(),
                                                    style: getMediumStyle(
                                                        color:
                                                            ColorManager.white,
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: OutlineGradientButton(
                                              padding: EdgeInsets.all(3.5),
                                              gradient: LinearGradient(colors: [
                                                Colors.white,
                                                Colors.white
                                              ]),
                                              strokeWidth: 5,
                                              radius: Radius.circular(55),
                                              child: controller.user == null
                                                  ? Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey.shade300,
                                                      highlightColor:
                                                          Colors.grey.shade100,
                                                      child: CircleAvatar(
                                                        radius: 40,
                                                      ),
                                                    )
                                                  : CircleAvatar(
                                                      radius: 40,
                                                      backgroundImage:
                                                          NetworkImage(controller
                                                              .user!
                                                              .user
                                                              .profilePicUrl!)),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(
                                                    FollowingsView(
                                                      followings:
                                                          controller.followings,
                                                      title: translate(
                                                          "My Followings"),
                                                    ),
                                                    arguments:
                                                        controller.followings,
                                                    transition: Transition
                                                        .rightToLeftWithFade);
                                                Get.find<UserController>()
                                                    .changeTabOpen(false);
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    translate("Followings"),
                                                    style: getMediumStyle(
                                                        color:
                                                            ColorManager.white,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(1),
                                                  ),
                                                  Text(
                                                    controller.user == null
                                                        ? "0"
                                                        : controller.user!.user
                                                            .followingCount!
                                                            .toString(),
                                                    style: getMediumStyle(
                                                        color:
                                                            ColorManager.white,
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: getVerticalSize(10),
                                                left: getHorizontalSize(10),
                                                right: getHorizontalSize(10)),
                                            alignment: Alignment.bottomCenter,
                                            height: 100,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(AllPosts());
                                                    Get.find<UserController>()
                                                        .changeTabOpen(false);
                                                  },
                                                  child: slideWidget(
                                                      controller.user == null
                                                          ? 0
                                                          : controller.user!
                                                              .user.mediaCount,
                                                      'Posts'),
                                                ),
                                                slideWidget(
                                                    controller.postMedias
                                                            .isNotEmpty
                                                        ? controller.postMedias
                                                            .map((e) => e!
                                                                .node!
                                                                .edgeMediaPreviewLike!
                                                                .count)
                                                            .reduce((value,
                                                                    element) =>
                                                                value! +
                                                                element!)!
                                                        : 0,
                                                    'Like'),
                                                slideWidget(
                                                    controller.postMedias
                                                            .isNotEmpty
                                                        ? controller.postMedias
                                                            .map((e) => e!
                                                                .node!
                                                                .edgeMediaToComment!
                                                                .count)
                                                            .reduce((value,
                                                                    element) =>
                                                                value! +
                                                                element!)!
                                                        : 0,
                                                    'Comment'),
                                                slideWidget(
                                                    controller.postMedias
                                                            .isNotEmpty
                                                        ? controller.postMedias
                                                            .where((e) => e!
                                                                .node!.isVideo!)
                                                            .toList()
                                                            .length
                                                        : 0,
                                                    'Video'),
                                                slideWidget(
                                                    controller.postMedias
                                                            .isNotEmpty
                                                        ? controller.postMedias
                                                            .where((e) => !e!
                                                                .node!.isVideo!)
                                                            .toList()
                                                            .length
                                                        : 0,
                                                    'Photo'),
                                              ],
                                            )),
                                      ),
                                    )
                                  ]),
                            ),
                            Container(
                              margin: margin,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: CardView(
                                      onTap: () {
                                        Get.to(
                                            FollowersView(
                                              followers: followersBox.values
                                                  .toList()
                                                  .where((element) =>
                                                      element.userIdForAccount !=
                                                          null &&
                                                      element.userIdForAccount ==
                                                          controller
                                                              .choosenAccount!
                                                              .userId &&
                                                      DateTime.now()
                                                              .difference(element
                                                                  .timestamp)
                                                              .inHours <
                                                          24 &&
                                                      element.stillFollower &&
                                                      !controller
                                                          .firstFollowersIds
                                                          .contains(element.pk
                                                              .toString()))
                                                  .toList(),
                                              title: translate("New Followers"),
                                            ),
                                            transition:
                                                Transition.rightToLeftWithFade);
                                      },
                                      count: !followersBox.isOpen
                                          ? "0"
                                          : followersBox.values
                                              .toList()
                                              .where((element) =>
                                                  element.userIdForAccount !=
                                                      null &&
                                                  element.userIdForAccount ==
                                                      controller.choosenAccount!
                                                          .userId &&
                                                  DateTime.now()
                                                          .difference(
                                                              element.timestamp)
                                                          .inHours <
                                                      24 &&
                                                  element.stillFollower &&
                                                  !controller.firstFollowersIds
                                                      .contains(element.pk
                                                          .toString()))
                                              .toList()
                                              .length
                                              .toString(),
                                      loading: controller.loadingFollowers,
                                      text: translate("New Followers"),
                                      icon: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Icon(
                                            CupertinoIcons.person_fill,
                                            color: ColorManager.primary,
                                            size: 20,
                                          ),
                                          CircleAvatar(
                                            radius: 5,
                                            backgroundColor:
                                                ColorManager.primary,
                                            child: Icon(
                                              Icons.add,
                                              size: 10,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: CardView(
                                        onTap: () {
                                          Get.to(
                                              FollowersView(
                                                followers: followersBox.values
                                                    .toList()
                                                    .where((element) =>
                                                        element.userIdForAccount !=
                                                            null &&
                                                        element.userIdForAccount ==
                                                            controller
                                                                .choosenAccount!
                                                                .userId &&
                                                        DateTime.now()
                                                                .difference(element
                                                                    .timestamp)
                                                                .inHours <
                                                            24 &&
                                                        !element.stillFollower)
                                                    .toList(),
                                                title: translate("UnFollowers"),
                                              ),
                                              transition: Transition
                                                  .rightToLeftWithFade);
                                        },
                                        loading: controller.loadingFollowers,
                                        count: !followersBox.isOpen
                                            ? "0"
                                            : followersBox.values
                                                .toList()
                                                .where((element) =>
                                                    element.userIdForAccount !=
                                                        null &&
                                                    element.userIdForAccount ==
                                                        controller
                                                            .choosenAccount!
                                                            .userId &&
                                                    DateTime.now()
                                                            .difference(element
                                                                .timestamp)
                                                            .inHours <
                                                        24 &&
                                                    !element.stillFollower)
                                                .toList()
                                                .length
                                                .toString(),
                                        text: translate("UnFollowers"),
                                        icon: Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Icon(
                                              CupertinoIcons.person_fill,
                                              color: ColorManager.primary,
                                              size: 20,
                                            ),
                                            CircleAvatar(
                                              radius: 5,
                                              backgroundColor:
                                                  ColorManager.primary,
                                              child: Icon(
                                                CupertinoIcons.minus,
                                                size: 10,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: margin,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: CardView(
                                      onTap: () {
                                        Get.to(
                                            FollowingsView(
                                              followings: followingsBox.values
                                                  .toList()
                                                  .where((element) =>
                                                      element.userIdForAccount !=
                                                          null &&
                                                      element.userIdForAccount ==
                                                          controller
                                                              .choosenAccount!
                                                              .userId &&
                                                      !controller.followersIds
                                                          .contains(element.pk
                                                              .toString()))
                                                  .toList(),
                                              title: translate(
                                                  "Not Following You Back"),
                                            ),
                                            transition:
                                                Transition.rightToLeftWithFade);
                                      },
                                      loading: controller.loadingFollowings,
                                      count: followingsBox.values
                                          .toList()
                                          .where((element) =>
                                              element.userIdForAccount !=
                                                  null &&
                                              element.userIdForAccount ==
                                                  controller
                                                      .choosenAccount!.userId &&
                                              !controller.followersIds.contains(
                                                  element.pk.toString()))
                                          .toList()
                                          .length
                                          .toString(),
                                      text: translate("Not Following You Back"),
                                      icon: Icon(
                                        Icons.backspace,
                                        color: ColorManager.primary,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: CardView(
                                        onTap: () {
                                          Get.to(
                                              FollowersView(
                                                followers: followersBox.values
                                                    .toList()
                                                    .where((element) =>
                                                        element.userIdForAccount !=
                                                            null &&
                                                        element.userIdForAccount ==
                                                            controller
                                                                .choosenAccount!
                                                                .userId &&
                                                        !controller.followingIds
                                                            .contains(element.pk
                                                                .toString()))
                                                    .toList(),
                                                title: translate(
                                                    "You Are Not Following"),
                                              ),
                                              transition: Transition
                                                  .rightToLeftWithFade);
                                        },
                                        loading: controller.loadingFollowers,
                                        count: followersBox.values
                                            .toList()
                                            .where((element) =>
                                                element.userIdForAccount !=
                                                    null &&
                                                element.userIdForAccount ==
                                                    controller.choosenAccount!
                                                        .userId &&
                                                !controller.followingIds
                                                    .contains(element.pk
                                                        .toString()) &&
                                                element.stillFollower)
                                            .toList()
                                            .length
                                            .toString(),
                                        text:
                                            translate("You Are Not Following"),
                                        icon: RotationTransition(
                                          turns:
                                              AlwaysStoppedAnimation(180 / 360),
                                          child: Icon(
                                            Icons.backspace,
                                            color: ColorManager.primary,
                                            size: 20,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: margin,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: CardView(
                                      onTap: () {
                                        Get.to(
                                            FollowersView(
                                              title: "Who Blocked You",
                                              followers: followersBox.values
                                                  .toList()
                                                  .where((element) =>
                                                      element.userIdForAccount !=
                                                          null &&
                                                      element.userIdForAccount ==
                                                          controller
                                                              .choosenAccount!
                                                              .userId &&
                                                      !element.stillFollower &&
                                                      controller.blockedUsers
                                                          .contains(element.pk
                                                              .toString()))
                                                  .toList(),
                                            ),
                                            transition:
                                                Transition.rightToLeftWithFade);
                                      },
                                      loading: controller.loadingBlocks,
                                      count: controller.blockedUsers.length
                                          .toString(),
                                      text: translate("Who Blocked You"),
                                      icon: Image.asset(
                                        "assets/images/block.png",
                                        color: ColorManager.primary,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: CardView(
                                      onTap: () {
                                        Get.to(
                                            FollowersView(
                                              followers: followersBox.values
                                                  .toList()
                                                  .where((element) =>
                                                      element.userIdForAccount !=
                                                          null &&
                                                      element.userIdForAccount ==
                                                          controller
                                                              .choosenAccount!
                                                              .userId &&
                                                      controller.followingIds
                                                          .contains(element.pk
                                                              .toString()))
                                                  .toList(),
                                              title:
                                                  translate("Mutual Following"),
                                            ),
                                            transition:
                                                Transition.rightToLeftWithFade);
                                      },
                                      loading: controller.loadingFollowers,
                                      count: followersBox.values
                                          .toList()
                                          .where((element) =>
                                              element.userIdForAccount !=
                                                  null &&
                                              element.userIdForAccount ==
                                                  controller
                                                      .choosenAccount!.userId &&
                                              controller.followingIds.contains(
                                                  element.pk.toString()))
                                          .toList()
                                          .length
                                          .toString(),
                                      text: translate("Mutual Following"),
                                      icon: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/heart.png",
                                            color: ColorManager.primary,
                                            width: 20,
                                          ),
                                          Icon(
                                            Icons.compare_arrows,
                                            color: ColorManager.primary,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: margin,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: CardView(
                                      onTap: () {
                                        Get.to(
                                            FollowingsView(
                                                followings: followingsBox.values
                                                    .toList()
                                                    .where((element) =>
                                                        element.userIdForAccount !=
                                                            null &&
                                                        element.userIdForAccount ==
                                                            controller
                                                                .choosenAccount!
                                                                .userId &&
                                                        controller.followingIds
                                                            .contains(
                                                          element.pk.toString(),
                                                        ) &&
                                                        DateTime.now()
                                                                .difference(element
                                                                    .timestamp)
                                                                .inHours <
                                                            24 &&
                                                        element
                                                            .stillFollowing &&
                                                        !controller
                                                            .firstFollowingIds
                                                            .contains(element.pk
                                                                .toString()))
                                                    .toList(),
                                                title: translate(
                                                  "New Followings",
                                                )),
                                            transition:
                                                Transition.rightToLeftWithFade);
                                      },
                                      loading: controller.loadingFollowings,
                                      count: followingsBox.values
                                          .toList()
                                          .where((element) =>
                                              element.userIdForAccount !=
                                                  null &&
                                              element.userIdForAccount ==
                                                  controller
                                                      .choosenAccount!.userId &&
                                              controller.followingIds.contains(
                                                element.pk.toString(),
                                              ) &&
                                              DateTime.now()
                                                      .difference(
                                                          element.timestamp)
                                                      .inHours <
                                                  24 &&
                                              element.stillFollowing &&
                                              !controller.firstFollowingIds
                                                  .contains(
                                                      element.pk.toString()))
                                          .toList()
                                          .length
                                          .toString(),
                                      text: translate(
                                        "New Followings",
                                      ),
                                      icon: Icon(
                                        Icons.favorite,
                                        size: 20,
                                        color: ColorManager.primary,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: CardView(
                                        onTap: () {
                                          Get.to(
                                              FollowingsView(
                                                followings: followingsBox.values
                                                    .toList()
                                                    .where((element) =>
                                                        element.userIdForAccount !=
                                                            null &&
                                                        element.userIdForAccount ==
                                                            controller
                                                                .choosenAccount!
                                                                .userId &&
                                                        DateTime.now()
                                                                .difference(element
                                                                    .timestamp)
                                                                .inHours <
                                                            24 &&
                                                        !element.stillFollowing)
                                                    .toList(),
                                                title:
                                                    translate("I Unfollowed"),
                                              ),
                                              transition: Transition
                                                  .rightToLeftWithFade);
                                        },
                                        loading: controller.loadingFollowings,
                                        count: !followingsBox.isOpen
                                            ? "0"
                                            : followingsBox.values
                                                .toList()
                                                .where((element) =>
                                                    element.userIdForAccount !=
                                                        null &&
                                                    element.userIdForAccount ==
                                                        controller
                                                            .choosenAccount!
                                                            .userId &&
                                                    DateTime.now()
                                                            .difference(element
                                                                .timestamp)
                                                            .inHours <
                                                        24 &&
                                                    !element.stillFollowing)
                                                .toList()
                                                .length
                                                .toString(),
                                        text: translate("I Unfollowed"),
                                        icon: Image.asset(
                                          "assets/images/broken_heart.png",
                                          color: ColorManager.primary,
                                          width: 20,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                }),
          ),
        ),
      );
    });
  }
}
