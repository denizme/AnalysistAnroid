import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/show_toast.dart';
import 'package:analysist/ui/profile/user_post_video.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../core/constants.dart';
import '../../core/gallery_saver.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/photo_detail.dart';
import '../../widgets/premium_glass.dart';
import '../home/ads_controller.dart';
import '../landing/user_controller.dart';

class UserPost extends StatelessWidget {
  String displayUrl;
  bool isVideo;
  String? videoUrl;
  UserPost(
      {Key? key,
      required this.displayUrl,
      required this.isVideo,
      this.videoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                child: InkWell(
                    onTap: () {
                      if (!isVideo) {
                        bool purchased = Get.find<UserController>().purchased;
                        if (!purchased) {
                          Get.find<AdsController>().createInterstitialAd();
                        }
                        Get.to(PhotoDetail(
                          photo: displayUrl,
                        ));
                      }
                    },
                    child: isVideo
                        ? UserPostVideo(
                            displayUrl: displayUrl,
                            videoUrl: videoUrl!,
                          )
                        : PhotoViewGallery.builder(
                            scrollPhysics: const BouncingScrollPhysics(),
                            builder: (BuildContext context, int index) {
                              return PhotoViewGalleryPageOptions(
                                imageProvider: NetworkImage(displayUrl),
                                initialScale:
                                    PhotoViewComputedScale.contained * 1,
                              );
                            },
                            itemCount: 1,
                            loadingBuilder: (context, event) => Center(
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  value: event == null
                                      ? 0
                                      : event.cumulativeBytesLoaded /
                                          event.expectedTotalBytes!.toInt(),
                                ),
                              ),
                            ),
                          )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    left: 15,
                    right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    FloatingActionButton.extended(
                      backgroundColor: ColorManager.primary,
                      label: Text(translate("Download")),
                      onPressed: () {
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
                      icon: Icon(
                        IconlyBold.download,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
