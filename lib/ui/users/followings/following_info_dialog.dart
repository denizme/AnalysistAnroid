import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/services/get_post_user.dart';
import 'package:analysist/services/info.dart';
import 'package:analysist/services/unfollow.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/profile/profile_controller.dart';
import 'package:analysist/ui/profile/user_profile.dart';
import 'package:analysist/widgets/photo_detail.dart';
import '../../../core/constants.dart';
import '../../../core/gallery_saver.dart';
import '../../../core/show_toast.dart';
import '../../../models/Followers.dart';
import '../../../models/Followings.dart';
import '../../../services/follow.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/premium_glass.dart';
import '../../home/ads_controller.dart';

class FollowingInfoDialog extends StatelessWidget {
  FollowingUsers user;
  FollowingInfoDialog({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: ColorManager.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        insetPadding: EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          child: GetBuilder<UserController>(builder: (controller) {
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: getVerticalSize(50),
                      ),
                      Text(
                        user.username!,
                        style: getBoldStyle(
                            color: ColorManager.primary, fontSize: 15),
                      ),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
                      ListTile(
                        onTap: () {
                          bool purchased = Get.find<UserController>().purchased;
                          if (!purchased) {
                            Get.find<AdsController>().createInterstitialAd();
                          }
                          Get.showOverlay(
                              asyncFunction: () async {
                                String? cookie = Get.find<UserController>()
                                    .choosenAccount!
                                    .cookie;
                                await Get.put(ProfileController())
                                    .getPostUser(user.username!)
                                    .then((value) {
                                  Get.to(UserProfile());
                                  Get.find<UserController>()
                                      .changeTabOpen(false);
                                });
                              },
                              loadingWidget: loading());
                        },
                        leading: CircleAvatar(
                          radius: 23,
                          backgroundColor: ColorManager.primary,
                          child: Icon(
                            Icons.person,
                            color: ColorManager.secondary,
                          ),
                        ),
                        title: Text(
                          translate(
                            'Go Profile',
                          ),
                          style: getBoldStyle(
                              color: ColorManager.primary, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: ColorManager.lightWhite,
                          thickness: 0.2,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          bool purchased = Get.find<UserController>().purchased;
                          if (!purchased) {
                            Get.find<AdsController>().createInterstitialAd();
                          }
                          Get.showOverlay(
                              asyncFunction: () async {
                                String? cookie = Get.find<UserController>()
                                    .choosenAccount!
                                    .cookie;
                                await info(user.pk.toString(), cookie)
                                    .then((value) {
                                  if (value != null) {
                                    value.user.hdProfilePicVersions!.sort(
                                        (a, b) => b.width.compareTo(a.width));

                                    String photo =
                                        value.user.hdProfilePicVersions![0].url;
                                    Get.to(PhotoDetail(
                                      photo: photo,
                                    ));
                                  }
                                });
                              },
                              loadingWidget: loading());
                        },
                        leading: CircleAvatar(
                          radius: 23,
                          backgroundColor: ColorManager.primary,
                          child: Icon(
                            Icons.remove_red_eye,
                            color: ColorManager.secondary,
                          ),
                        ),
                        title: Text(
                          translate(
                            'See Big HD Profile Photo',
                          ),
                          style: getBoldStyle(
                              color: ColorManager.primary, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: ColorManager.lightWhite,
                          thickness: 0.2,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          bool purchased = Get.find<UserController>().purchased;
                          if (!purchased) {
                            Get.find<AdsController>().createInterstitialAd();
                          }

                          if (!purchased) {
                            Get.dialog(Material(
                                color: Colors.transparent,
                                child: PremiumGlass()));
                          } else {
                            Get.showOverlay(
                                asyncFunction: () async {
                                  String? cookie = Get.find<UserController>()
                                      .choosenAccount!
                                      .cookie;
                                  await info(user.pk!.toString(), cookie)
                                      .then((value) async {
                                    if (value != null) {
                                      value.user.hdProfilePicVersions!.sort(
                                          (a, b) => b.width.compareTo(a.width));

                                      String photo = value
                                          .user.hdProfilePicVersions![0].url;
                                      await GallerySaver()
                                          .savePhoto(photo)
                                          .then((value) {
                                        if (value) {
                                          showToast(
                                            translate("Saved Gallery Image"),
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
                        leading: CircleAvatar(
                          radius: 23,
                          backgroundColor: ColorManager.primary,
                          child: Icon(
                            IconlyBold.download,
                            color: ColorManager.secondary,
                          ),
                        ),
                        title: Text(
                          translate(
                            'Download HD Profile Photo',
                          ),
                          style: getBoldStyle(
                              color: ColorManager.primary, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: ColorManager.lightWhite,
                          thickness: 0.2,
                        ),
                      ),
                      !controller.followingIds.contains(user.pk.toString())
                          ? ListTile(
                              onTap: () {
                                Get.showOverlay(
                                    asyncFunction: () async {
                                      String? cookie =
                                          controller.choosenAccount!.cookie;
                                      String? csrfToken =
                                          controller.choosenAccount!.csrfToken;
                                      await follow(user.pk.toString(), cookie,
                                              csrfToken)
                                          .then((value) async {
                                        if (value) {
                                          await postUser(user.username!, cookie)
                                              .then((postUser) {
                                            if (postUser!.data.user
                                                    .followedByViewer ==
                                                true) {
                                              showToast(
                                                "You started following",
                                              );
                                              // controller.addFollowing(user);
                                            } else {
                                              showToast(
                                                "Follow request sent",
                                              );
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
                              leading: CircleAvatar(
                                radius: 23,
                                backgroundColor: ColorManager.primary,
                                child: Icon(
                                  IconlyBold.add_user,
                                  color: ColorManager.secondary,
                                ),
                              ),
                              title: Text(
                                translate('Follow User'),
                                style: getBoldStyle(
                                    color: ColorManager.primary, fontSize: 15),
                              ),
                            )
                          : ListTile(
                              onTap: () {
                                Get.showOverlay(
                                    asyncFunction: () async {
                                      String? cookie =
                                          controller.choosenAccount!.cookie;
                                      String csrfToken =
                                          controller.choosenAccount!.csrfToken;
                                      await unfollow(user.pk.toString(), cookie,
                                              csrfToken)
                                          .then((value) async {
                                        if (value) {
                                          showToast(
                                            "Unfollowed User",
                                          );
                                          // controller.removeFollowing(user);
                                        } else {
                                          showToast(
                                            "Request Failed",
                                          );
                                        }
                                      });
                                    },
                                    loadingWidget: loading());
                              },
                              leading: CircleAvatar(
                                radius: 23,
                                backgroundColor: ColorManager.primary,
                                child: Icon(
                                  Icons.person_remove_rounded,
                                  color: ColorManager.primary,
                                ),
                              ),
                              title: Text(
                                'UnFollow User',
                                style: getBoldStyle(
                                    color: ColorManager.primary, fontSize: 15),
                              ),
                            ),
                      SizedBox(
                        height: getVerticalSize(5),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: -40,
                    child: CircleAvatar(
                      radius: 41.5,
                      backgroundColor: ColorManager.secondary,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage(user.profilePicUrl.toString()),
                      ),
                    )),
              ],
            );
          }),
        ));
  }
}
