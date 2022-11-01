import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/show_toast.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/models/PostUser.dart';
import 'package:analysist/services/get_followings.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/profile/post_options.dart';
import 'package:analysist/ui/profile/profile_controller.dart';
import 'package:analysist/ui/profile/refresher.dart';
import 'package:analysist/ui/profile/user_post.dart';
import 'package:analysist/ui/stories/stories_controller.dart';
import 'package:analysist/ui/users/followers/followers.dart';
import 'package:analysist/ui/users/followings/followings.dart';
import 'package:loading_progress_indicator/loading_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_beat_progress_indicator.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/gallery_saver.dart';
import '../../models/Highlighted.dart';
import '../../models/Stories.dart';
import '../../services/follow.dart';
import '../../services/get_followers.dart';
import '../../services/info.dart';
import '../../services/unfollow.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/photo_detail.dart';
import '../../widgets/premium_glass.dart';
import '../home/ads_controller.dart';
import '../stories/story_view.dart';

class UserProfile extends StatefulWidget {
  bool fromStory;
  UserProfile({this.fromStory = false});
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ScrollController scrollController = ScrollController();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  void onRefresh() async {
    // monitor network fetch
    Get.put(ProfileController());
    await Get.find<ProfileController>()
        .getPostUser(Get.find<ProfileController>().userName);
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    logger.i(Get.find<ProfileController>().userId!);
    try {
      await Get.find<ProfileController>()
          .getMorePost(Get.find<ProfileController>().userId!)
          .then((value) {
        refreshController.twoLevelComplete();
        refreshController.loadComplete();
      });
    } catch (e) {
      await Get.put(ProfileController())
          .getMorePost(Get.find<ProfileController>().userId!)
          .then((value) {
        refreshController.twoLevelComplete();
        refreshController.loadComplete();
      });
    }

    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  @override
  Widget build(BuildContext context) {
    Get.put(StoriesController());
    return GetBuilder<ProfileController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () {
          if (widget.fromStory) {
          } else {
            Get.find<UserController>().changeTabOpen(true);
          }

          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: kToolbarHeight - 5,
            backgroundColor: ColorManager.secondary,
            shadowColor: Colors.grey.shade200,
            elevation: 2,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: ColorManager.primary,
                )),
            centerTitle: false,
            title: Text(controller.user!.data.user.fullName!,
                style: getRegularStyle(
                  fontSize: 16,
                  color: ColorManager.primary,
                )),
          ),
          backgroundColor: ColorManager.backgroundColor,
          body: GetBuilder<ProfileController>(builder: (controller) {
            return Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.only(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: getVerticalSize(10),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getHorizontalSize(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            InkWell(
                              onTap: () {
                                // bool purchased =
                                //     Get.find<UserController>().purchased;
                                // if (!purchased) {
                                //   Get.find<AdsController>()
                                //       .createInterstitialAd();
                                // }
                                // Get.showOverlay(
                                //     asyncFunction: () async {
                                //       String? cookie = Get.find<UserController>()
                                //           .choosenAccount!
                                //           .cookie;

                                //       await info(
                                //               controller.user!.data.user.id!
                                //                   .toString(),
                                //               cookie)
                                //           .then((value) {
                                //         if (value != null) {
                                //           value.user.hdProfilePicVersions!.sort(
                                //               (a, b) =>
                                //                   b.width.compareTo(a.width));

                                //           String photo = value
                                //               .user.hdProfilePicVersions![0].url;
                                //           Get.to(PhotoDetail(
                                //             photo: photo,
                                //           ));
                                //         }
                                //       });
                                //     },
                                //     loadingWidget: loading());
                                if (controller.userStories != null) {
                                  bool purchased =
                                      Get.find<UserController>().purchased;
                                  if (!purchased) {
                                    Get.find<AdsController>()
                                        .createInterstitialAd();
                                  }

                                  Get.to(
                                      StoryViewPage(
                                        reelId: controller.userStories!.id,
                                        items: controller.userStories!.items,
                                        user: controller.userStories!.user!,
                                      ),
                                      duration: Duration(milliseconds: 200),
                                      transition: Transition.circularReveal);
                                  Get.find<UserController>()
                                      .changeTabOpen(false);
                                  Get.find<UserController>()
                                      .changeHideBanner(false);
                                }
                              },
                              child: OutlineGradientButton(
                                padding: EdgeInsets.all(3.5),
                                gradient: LinearGradient(
                                    colors: controller.userStories == null ||
                                            controller
                                                .userStories!.items!.isEmpty
                                        ? [Colors.grey, Colors.grey]
                                        : [Colors.pink, Colors.purple]),
                                strokeWidth: 3,
                                radius: Radius.circular(50),
                                child: CircleAvatar(
                                  radius: 38.5,
                                  child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(controller
                                          .user!.data.user.profilePicUrl!)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: InkWell(
                                onTap: () {
                                  bool purchased =
                                      Get.find<UserController>().purchased;
                                  if (!purchased) {
                                    Get.find<AdsController>()
                                        .createInterstitialAd();
                                  }

                                  if (!purchased) {
                                    Get.dialog(Material(
                                        color: Colors.transparent,
                                        child: PremiumGlass()));
                                  } else {
                                    Get.showOverlay(
                                        asyncFunction: () async {
                                          String? cookie =
                                              Get.find<UserController>()
                                                  .choosenAccount!
                                                  .cookie;
                                          await info(
                                                  controller.user!.data.user.id!
                                                      .toString(),
                                                  cookie)
                                              .then((value) async {
                                            if (value != null) {
                                              value.user.hdProfilePicVersions!
                                                  .sort((a, b) => b.width
                                                      .compareTo(a.width));

                                              String photo = value.user
                                                  .hdProfilePicVersions![0].url;
                                              await GallerySaver()
                                                  .savePhoto(photo)
                                                  .then((value) {
                                                if (value) {
                                                  showToast(
                                                    translate(
                                                        "Saved Gallery Image"),
                                                  );
                                                } else {
                                                  showToast(
                                                    "Failed to Save gallery Image",
                                                  );
                                                }
                                              });
                                            }
                                          });
                                        },
                                        loadingWidget: loading());
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.blueAccent,
                                  child: CircleAvatar(
                                    radius: 12.8,
                                    child: Icon(
                                      Icons.download,
                                      size: 18,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     bool purchased =
                        //         Get.find<UserController>().purchased;
                        //     if (!purchased) {
                        //       Get.find<AdsController>().createInterstitialAd();
                        //     }
                        //     Get.showOverlay(
                        //         asyncFunction: () async {
                        //           String? cookie = Get.find<UserController>()
                        //               .choosenAccount!
                        //               .cookie;

                        //           await info(
                        //                   controller.user!.data.user.id
                        //                       .toString(),
                        //                   cookie)
                        //               .then((value) {
                        //             if (value != null) {
                        //               value.user.hdProfilePicVersions!.sort(
                        //                   (a, b) => b.width.compareTo(a.width));

                        //               String photo = value
                        //                   .user.hdProfilePicVersions![0].url;
                        //               Get.to(PhotoDetail(
                        //                 photo: photo,
                        //               ));
                        //             }
                        //           });
                        //         },
                        //         loadingWidget: loading());
                        //   },
                        //   child: OutlineGradientButton(
                        //     padding: EdgeInsets.all(2.5),
                        //     gradient: LinearGradient(
                        //         colors: [Colors.pink, Colors.purple]),
                        //     strokeWidth: 3,
                        //     radius: Radius.circular(50),
                        //     child: controller.user == null
                        //         ? Shimmer.fromColors(
                        //             baseColor: Colors.grey.shade300,
                        //             highlightColor: Colors.grey.shade100,
                        //             child: CircleAvatar(
                        //               radius: 30,
                        //             ),
                        //           )
                        //         : CircleAvatar(
                        //             radius: 30,
                        //             backgroundImage: NetworkImage(controller
                        //                 .user!.data.user.profilePicUrl!)),
                        //   ),
                        // ),

                        SizedBox(
                          width: getHorizontalSize(20),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Text(
                                            controller.user == null
                                                ? "0"
                                                : controller
                                                    .user!
                                                    .data
                                                    .user
                                                    .edgeOwnerToTimelineMedia!
                                                    .count!
                                                    .toString(),
                                            style: getBoldStyle(
                                                color: ColorManager.primary,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(2),
                                          ),
                                          Text(
                                            translate(
                                              'Posts',
                                            ),
                                            style: getMediumStyle(
                                                color: ColorManager.primary,
                                                fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: () {
                                          bool purchased =
                                              Get.find<UserController>()
                                                  .purchased;
                                          if (!purchased) {
                                            Get.find<AdsController>()
                                                .createInterstitialAd();
                                          }
                                          Get.showOverlay(
                                              asyncFunction: () async {
                                                String? cookie =
                                                    Get.find<UserController>()
                                                        .choosenAccount!
                                                        .cookie;
                                                await getFollowers(
                                                        controller.user!.data
                                                            .user.id!,
                                                        cookie)
                                                    .then((value) {
                                                  Get.to(
                                                      FollowersView(
                                                        title: controller
                                                                .user!
                                                                .data
                                                                .user
                                                                .username
                                                                .toString() +
                                                            " Followers",
                                                        followers: value!.users,
                                                      ),
                                                      transition: Transition
                                                          .rightToLeftWithFade);
                                                });
                                              },
                                              loadingWidget: loading());
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              controller.user == null
                                                  ? "0"
                                                  : controller.user!.data.user
                                                      .edgeFollowedBy!.count
                                                      .toString(),
                                              style: getBoldStyle(
                                                  color: ColorManager.primary,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(2),
                                            ),
                                            Text(
                                              translate(
                                                'Followers',
                                              ),
                                              style: getMediumStyle(
                                                  color: ColorManager.primary,
                                                  fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          bool purchased =
                                              Get.find<UserController>()
                                                  .purchased;
                                          if (!purchased) {
                                            Get.find<AdsController>()
                                                .createInterstitialAd();
                                          }
                                          Get.showOverlay(
                                              asyncFunction: () async {
                                                String? cookie =
                                                    Get.find<UserController>()
                                                        .choosenAccount!
                                                        .cookie;
                                                ;
                                                await getFollowings(
                                                        controller.user!.data
                                                            .user.id!,
                                                        cookie)
                                                    .then((value) {
                                                  Get.to(
                                                      FollowingsView(
                                                        title: controller
                                                                .user!
                                                                .data
                                                                .user
                                                                .username
                                                                .toString() +
                                                            " Followings",
                                                        followings:
                                                            value!.users,
                                                      ),
                                                      transition: Transition
                                                          .rightToLeftWithFade);
                                                });
                                              },
                                              loadingWidget: loading());
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              controller.user == null
                                                  ? "0"
                                                  : controller.user!.data.user
                                                      .edgeFollow!.count
                                                      .toString(),
                                              style: getBoldStyle(
                                                  color: ColorManager.primary,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(2),
                                            ),
                                            Text(
                                              translate(
                                                'Followings',
                                              ),
                                              style: getMediumStyle(
                                                  color: ColorManager.primary,
                                                  fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                controller.user!.data.user.followedByViewer ==
                                        true
                                    ? Container(
                                        height: 25,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              textStyle: getMediumStyle(
                                                  color: Colors.white),
                                              shadowColor: Colors.transparent,
                                              onPrimary: Colors.grey,
                                              primary: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10)),
                                          onPressed: () {
                                            Get.showOverlay(
                                                asyncFunction: () async {
                                                  String? cookie =
                                                      Get.find<UserController>()
                                                          .choosenAccount!
                                                          .cookie;
                                                  String csrfToken =
                                                      Get.find<UserController>()
                                                          .choosenAccount!
                                                          .csrfToken;
                                                  await unfollow(
                                                          controller.user!.data
                                                              .user.id
                                                              .toString(),
                                                          cookie,
                                                          csrfToken)
                                                      .then((value) async {
                                                    if (value) {
                                                      showToast(translate(
                                                        "Unfollowed User",
                                                      ));
                                                      Get.find<UserController>()
                                                          .removeFollowingPostUser(
                                                              controller.user!);
                                                    } else {
                                                      showToast(translate(
                                                        "Request Failed",
                                                      ));
                                                    }
                                                  });
                                                },
                                                loadingWidget: loading());
                                          },
                                          child: Text(translate('UnFollow')),
                                        ),
                                      )
                                    : Container(
                                        height: 25,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.transparent,
                                              onPrimary: Colors.blueAccent,
                                              shadowColor: Colors.transparent,
                                              textStyle: getMediumStyle(
                                                  color: Colors.white),
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: Colors.blueAccent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10)),
                                          onPressed: () {
                                            Get.showOverlay(
                                                asyncFunction: () async {
                                                  String? cookie =
                                                      Get.find<UserController>()
                                                          .choosenAccount!
                                                          .cookie;
                                                  String? csrfToken =
                                                      Get.find<UserController>()
                                                          .choosenAccount!
                                                          .csrfToken;
                                                  await follow(
                                                          controller.user!.data
                                                              .user.id
                                                              .toString(),
                                                          cookie,
                                                          csrfToken)
                                                      .then((value) async {
                                                    if (value) {
                                                      await controller
                                                          .getPostUser(
                                                              controller
                                                                  .user!
                                                                  .data
                                                                  .user
                                                                  .username!)
                                                          .then((postUser) {
                                                        if (postUser != null) {
                                                          if (postUser.data.user
                                                                  .followedByViewer ==
                                                              true) {
                                                            showToast(translate(
                                                              "You started following",
                                                            ));
                                                            Get.find<
                                                                    UserController>()
                                                                .addFollowingPostUser(
                                                                    controller
                                                                        .user!);
                                                          } else {
                                                            showToast(translate(
                                                                "Follow request sent"));
                                                          }
                                                        } else {
                                                          showToast(translate(
                                                            "Request Failed",
                                                          ));
                                                        }
                                                      });
                                                    } else {
                                                      showToast(
                                                        "Request Failed",
                                                      );
                                                    }
                                                  });
                                                },
                                                loadingWidget: loading());
                                          },
                                          child: Text(translate('Follow')),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getVerticalSize(12),
                  ),

                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   child: controller.user == null
                  //       ? Shimmer.fromColors(
                  //           baseColor: Colors.grey.shade100,
                  //           highlightColor: Colors.grey.shade300,
                  //           child: Container(
                  //             width: getHorizontalSize(150),
                  //             height: 18,
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white.withOpacity(0.3),
                  //                 borderRadius: BorderRadius.circular(5)),
                  //           ),
                  //         )
                  //       : Row(
                  //           children: [
                  //             Text(
                  //               controller.user!.data.user.username!,
                  //               style: getBoldStyle(
                  //                   color: Colors.white, fontSize: 13),
                  //             ),
                  //             SizedBox(
                  //               width: getHorizontalSize(5),
                  //             ),
                  //             controller.user == null
                  //                 ? Container()
                  //                 : controller.user!.data.user.isVerified!
                  //                     ? Padding(
                  //                         padding:
                  //                             const EdgeInsets.only(bottom: 3),
                  //                         child: Container(
                  //                           alignment: Alignment.centerRight,
                  //                           padding: EdgeInsets.only(
                  //                               right: getVerticalSize(75)),
                  //                           child: CircleAvatar(
                  //                             radius: 7,
                  //                             backgroundColor: Colors.blueAccent,
                  //                             child: Icon(
                  //                               Icons.check,
                  //                               size: 10,
                  //                               color: Colors.white,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       )
                  //                     : Container()
                  //           ],
                  //         ),
                  // ),
                  SizedBox(
                    height: getVerticalSize(10),
                  ),
                  controller.user == null
                      ? Container()
                      : controller.user!.data.user.biography == null ||
                              controller.user!.data.user.biography!.isEmpty
                          ? Container()
                          : Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(
                                  horizontal: getHorizontalSize(12),
                                  vertical: getVerticalSize(0)),
                              child: Text(
                                controller.user!.data.user.biography!
                                    .toString(),
                                style: getRegularStyle(
                                    color: ColorManager.primary, fontSize: 12),
                              ),
                            ),
                  SizedBox(
                    height: getVerticalSize(10),
                  ),
                  controller.highlighted == null ||
                          controller
                              .highlighted!.edgeHighlightReels.edges.isEmpty
                      ? Container()
                      : Container(
                          height: 80,
                          margin: EdgeInsets.only(
                            bottom: 8,
                            top: 5,
                            left: 10,
                          ),
                          child: ListView.builder(
                              itemCount: controller
                                  .highlighted!.edgeHighlightReels.edges.length,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                HighlightEdge edge = controller.highlighted!
                                    .edgeHighlightReels.edges[index];

                                return InkWell(
                                  onTap: () async {
                                    bool purchased =
                                        Get.find<UserController>().purchased;
                                    if (!purchased) {
                                      Get.find<AdsController>()
                                          .createInterstitialAd();
                                    }
                                    Get.showOverlay(
                                        asyncFunction: () async {
                                          Stories? stories = await controller
                                              .getHighlihtedStory(
                                                  controller.userId!,
                                                  edge.node!.id!);

                                          if (stories != null) {
                                            // if (!purchased) {
                                            //   Get.find<AdsController>()
                                            //       .createInterstitialAd();
                                            // }

                                            Get.to(
                                                StoryViewPage(
                                                  reelId: stories.id,
                                                  user: stories.user!,
                                                  items: stories.items,
                                                ),
                                                duration:
                                                    Duration(milliseconds: 200),
                                                transition:
                                                    Transition.circularReveal);
                                            Get.find<UserController>()
                                                .changeTabOpen(false);
                                            Get.find<UserController>()
                                                .changeHideBanner(false);
                                          }
                                        },
                                        loadingWidget: loading());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        right: index ==
                                                controller
                                                        .highlighted!
                                                        .edgeHighlightReels
                                                        .edges
                                                        .length -
                                                    1
                                            ? 0
                                            : 6),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        OutlineGradientButton(
                                          padding: EdgeInsets.all(3.5),
                                          gradient: LinearGradient(colors: [
                                            Colors.pink,
                                            Colors.purple
                                          ]),
                                          strokeWidth: 2,
                                          radius: Radius.circular(50),
                                          child: CircleAvatar(
                                            radius: 26,
                                            backgroundImage: NetworkImage(edge
                                                .node!
                                                .coverMediaCroppedThumbnail!
                                                .url),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Container(
                                          width: size.width / 6,
                                          child: Text(
                                            edge.node!.title!,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: getMediumStyle(
                                                color: ColorManager.primary,
                                                fontSize: 8),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                  Expanded(
                    child: controller.user!.data.user.edgeOwnerToTimelineMedia!
                            .edges!.isEmpty
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconlyBold.activity,
                                  color: ColorManager.secondary,
                                  size: 100,
                                ),
                                SizedBox(
                                  height: getVerticalSize(10),
                                ),
                                Text(
                                    translate(
                                      'Media Not Found',
                                    ),
                                    style: getRegularStyle(
                                        color: ColorManager.secondary,
                                        fontSize: 20))
                              ],
                            ),
                          )
                        : SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            header: WaterDropHeader(
                              waterDropColor: ColorManager.primary,
                              refresh: LoadingProgressIndicator(
                                  indicator: BallBeatProgressIndicator(),
                                  size: 50,
                                  color: ColorManager.primary),
                              complete: CircleAvatar(
                                radius: 13,
                                backgroundColor: ColorManager.primary,
                                child: Icon(Icons.check,
                                    size: 20, color: ColorManager.lightWhite),
                              ),
                            ),
                            footer: CustomFooter(
                              builder:
                                  (BuildContext context, LoadStatus? mode) {
                                Widget body;
                                if (mode == LoadStatus.idle) {
                                  body = Container();
                                } else if (mode == LoadStatus.loading) {
                                  body = LoadingProgressIndicator(
                                      indicator: BallBeatProgressIndicator(),
                                      size: 50,
                                      color: ColorManager.primary);
                                } else if (mode == LoadStatus.failed) {
                                  body = Text("Load Failed!Click retry!");
                                } else if (mode == LoadStatus.canLoading) {
                                  body = Text(
                                    "release to load more",
                                    style: getRegularStyle(
                                        color: ColorManager.secondary),
                                  );
                                } else {
                                  body = Text("No more Data");
                                }
                                return Container(
                                  height: 55.0,
                                  child: Center(child: body),
                                );
                              },
                            ),
                            controller: refreshController,
                            onRefresh: onRefresh,
                            onLoading: onLoading,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 2),
                              itemCount: controller.user!.data.user
                                  .edgeOwnerToTimelineMedia!.edges!.length,
                              itemBuilder: (BuildContext ctx, index) {
                                Edge edge = controller.user!.data.user
                                    .edgeOwnerToTimelineMedia!.edges![index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => UserPost(
                                        displayUrl: edge.node!.displayUrl!,
                                        isVideo: edge.node!.isVideo!,
                                        videoUrl: edge.node!.isVideo!
                                            ? edge.node!.videoUrl!
                                            : null,
                                      ),
                                    );
                                  },
                                  onLongPress: () {
                                    Get.to(PostOptions(
                                      displayUrl: edge.node!.displayUrl!,
                                      isVideo: edge.node!.isVideo!,
                                      videoUrl: edge.node!.isVideo!
                                          ? edge.node!.videoUrl!
                                          : null,
                                    ));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    edge.node!.displayUrl!))),
                                      ),
                                      edge.node!.isVideo!
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Icon(
                                                IconlyBold.video,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            )
                                          : Container(),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.cloud_download,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                  )
                ],
              ),
            );
          }),
        ),
      );
    });
  }
}
