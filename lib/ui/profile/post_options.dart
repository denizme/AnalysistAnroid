import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/ui/home/ads_controller.dart';
import 'package:analysist/ui/profile/user_post_video.dart';

import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../core/gallery_saver.dart';
import '../../core/math_utils.dart';
import '../../core/show_toast.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/photo_detail.dart';
import '../../widgets/premium_glass.dart';
import '../landing/user_controller.dart';

class PostOptions extends StatelessWidget {
  String displayUrl;
  bool isVideo;
  String? videoUrl;
  PostOptions(
      {Key? key,
      required this.displayUrl,
      required this.isVideo,
      required this.videoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: ColorManager.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        insetPadding: EdgeInsets.symmetric(horizontal: 30),
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
                    ListTile(
                      onTap: () {
                        bool purchased = Get.find<UserController>().purchased;
                        if (!purchased) {
                          Get.find<AdsController>().createInterstitialAd();
                        }
                        if (!isVideo) {
                          bool purchased = Get.find<UserController>().purchased;
                          if (!purchased) {
                            Get.find<AdsController>().createInterstitialAd();
                          }
                          Get.to(PhotoDetail(
                            photo: displayUrl,
                          ));
                        } else {
                          Get.to(UserPostVideo(
                            displayUrl: displayUrl,
                            videoUrl: videoUrl!,
                          ));
                        }
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
                          'See HD Post',
                        ),
                        style: getBoldStyle(color: Colors.white, fontSize: 15),
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
                                if (!isVideo) {
                                  await GallerySaver()
                                      .savePhoto(displayUrl)
                                      .then((value) {
                                    if (value) {
                                      showToast(
                                        translate("Saved Gallery Image"),
                                      );
                                    } else {
                                      showToast(translate(
                                        "Failed to Save gallery Image",
                                      ));
                                    }
                                  });
                                } else {
                                  await GallerySaver()
                                      .saveVideo(videoUrl!)
                                      .then((value) {
                                    if (value) {
                                      showToast(
                                        translate("Saved Gallery Video"),
                                      );
                                    } else {
                                      showToast(translate(
                                        "Failed to Save Gallery Video",
                                      ));
                                    }
                                  });
                                }
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
                        translate(
                          'Download HD Post',
                        ),
                        style: getBoldStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: getVerticalSize(5),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
