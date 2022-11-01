import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/gallery_saver.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/services/get_post_user.dart';
import 'package:analysist/services/info.dart';
import 'package:analysist/services/unfollow.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/profile/profile_controller.dart';
import 'package:analysist/ui/profile/user_profile.dart';
import 'package:analysist/ui/search/SearchUser.dart';
import 'package:analysist/widgets/photo_detail.dart';
import 'package:analysist/widgets/premium_glass.dart';
import '../../core/show_toast.dart';
import '../../services/follow.dart';
import '../../widgets/loading_widget.dart';
import '../home/ads_controller.dart';

class SearchUserInfoDialog extends StatelessWidget {
  SearchUser user;
  SearchUserInfoDialog({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: ColorManager.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        insetPadding: EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.secondary),
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
                        user.user.username!,
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

                                Get.put(ProfileController());
                                await Get.find<ProfileController>()
                                    .getPostUser(user.user.username!)
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
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          translate("Go Profile"),
                          style: getBoldStyle(
                              color: ColorManager.primary, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: Colors.grey,
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

                                await info(user.user.pk!.toString(), cookie)
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
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          translate(
                            'See HD Profile Photo',
                          ),
                          style: getBoldStyle(
                              color: ColorManager.primary, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.2,
                        ),
                      ),
                      !controller.followingIds
                              .contains(user.user.pk!.toString())
                          ? ListTile(
                              onTap: () {
                                Get.showOverlay(
                                    asyncFunction: () async {
                                      String? cookie =
                                          controller.choosenAccount!.cookie;
                                      String? csrfToken =
                                          controller.choosenAccount!.csrfToken;
                                      await follow(user.user.pk!.toString(),
                                              cookie, csrfToken)
                                          .then((value) async {
                                        if (value) {
                                          await postUser(
                                                  user.user.username!
                                                      .toString(),
                                                  cookie)
                                              .then((postUser) {
                                            if (postUser!.data.user
                                                    .followedByViewer ==
                                                true) {
                                              showToast(
                                                "You started following",
                                              );
                                              controller
                                                  .addFollowingSearchUser(user);
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
                                  color: Colors.white,
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
                                          Get.find<UserController>()
                                              .choosenAccount!
                                              .csrfToken;
                                      await unfollow(
                                              user.user.pk!
                                                  .toString()
                                                  .toString(),
                                              cookie,
                                              csrfToken)
                                          .then((value) async {
                                        if (value) {
                                          showToast(
                                            "Unfollowed User",
                                          );
                                          controller
                                              .removeFollowingSearchUser(user);
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
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                translate('UnFollow User'),
                                style: getBoldStyle(
                                    color: ColorManager.primary, fontSize: 15),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: Colors.grey,
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
                                  await info(user.user.pk!.toString(), cookie)
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
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          translate("Download HD Profile Photo"),
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
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage(user.user.profilePicUrl!.toString()),
                    ),
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
