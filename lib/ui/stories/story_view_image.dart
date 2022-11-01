import 'dart:async';

import 'package:flutter/material.dart';
import 'package:analysist/core/gallery_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:analysist/core/colors.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import '../../core/constants.dart';
import '../../core/show_toast.dart';
import '../../core/styles_manager.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/premium_glass.dart';
import '../home/ads_controller.dart';
import '../landing/user_controller.dart';
import '../profile/profile_controller.dart';
import '../profile/user_profile.dart';

class StoryViewImage extends StatefulWidget {
  String link;
  Function(int) initSeconds;
  VoidCallback next;
  VoidCallback pause;
  VoidCallback play;
  double milliseconds;
  String userName;
  StoryViewImage({
    Key? key,
    required this.initSeconds,
    required this.pause,
    required this.play,
    required this.userName,
    required this.milliseconds,
    required this.link,
    required this.next,
  }) : super(key: key);

  @override
  State<StoryViewImage> createState() => _StoryViewImageState();
}

class _StoryViewImageState extends State<StoryViewImage> {
  @override
  void initState() {
    widget.initSeconds(5000);
    finish();
    super.initState();
  }

  Timer? t;
  finish([int milliseconds = 5000]) async {
    t = Timer(Duration(milliseconds: milliseconds), () async {
      if (mounted) {
        widget.next();
      }
    });
  }

  pause() {
    setState(() {
      t!.cancel();
      widget.pause();
    });
  }

  play() {
    setState(() {
      widget.play();
      logger.i(widget.milliseconds * 5000);
      finish((5000 - (widget.milliseconds * 5000)).toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        AspectRatio(
          aspectRatio: 9 / 16,
          child: Image.network(widget.link),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                backgroundColor: ColorManager.primary,
                onPressed: () {
                  if (t!.isActive) {
                    pause();
                  } else {
                    play();
                  }

                  setState(() {});
                },
                child: Icon(t!.isActive ? Icons.pause : Icons.play_arrow),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SpeedDial(
                  child: Icon(
                    IconlyBold.arrow_up,
                    color: Colors.white,
                  ),
                  speedDialChildren: <SpeedDialChild>[
                    SpeedDialChild(
                      child: const Icon(IconlyBold.download),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      label: translate('Download Story'),
                      onPressed: () async {
                        bool purchased = Get.find<UserController>().purchased;
                        if (!purchased) {
                          Get.find<AdsController>().createInterstitialAd();
                        }
                        if (!purchased) {
                          pause();
                          Get.dialog(Material(
                              color: Colors.transparent,
                              child: PremiumGlass()));
                        } else {
                          Get.showOverlay(
                              asyncFunction: () async {
                                await GallerySaver()
                                    .savePhoto(widget.link)
                                    .then((value) {
                                  if (value) {
                                    showToast(
                                      translate("Saved Gallery Video"),
                                    );
                                  } else {
                                    showToast(
                                      "Failed to Save gallery Video",
                                    );
                                  }
                                });
                              },
                              loadingWidget: loading());
                        }
                      },
                    ),
                    SpeedDialChild(
                      child: const Icon(
                        CupertinoIcons.person_fill,
                        color: Colors.white,
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      label: translate('Go User Profile'),
                      onPressed: () {
                        Get.showOverlay(
                            asyncFunction: () async {
                              String? cookie = Get.find<UserController>()
                                  .choosenAccount!
                                  .cookie;
                              pause();
                              await Get.put(ProfileController())
                                  .getPostUser(widget.userName)
                                  .then((value) {
                                Get.to(UserProfile(
                                  fromStory: true,
                                ));
                                Get.find<UserController>().changeTabOpen(false);
                              });
                            },
                            loadingWidget: loading());
                      },
                    ),
                  ],
                  labelsStyle: getMediumStyle(color: Colors.white),
                  labelsBackgroundColor: ColorManager.primary,
                  closedForegroundColor: ColorManager.primary,
                  openForegroundColor: ColorManager.primary,
                  closedBackgroundColor: ColorManager.primary,
                  openBackgroundColor: ColorManager.primary,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
