import 'package:analysist/core/gallery_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:analysist/core/colors.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:video_player/video_player.dart';

import '../../core/constants.dart';
import '../../core/show_toast.dart';
import '../../core/styles_manager.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/premium_glass.dart';
import '../home/ads_controller.dart';
import '../landing/user_controller.dart';
import '../profile/profile_controller.dart';
import '../profile/user_profile.dart';

class StoryViewVideo extends StatefulWidget {
  String link;
  Function(int) initSeconds;
  Function(int?) pausePlay;
  String userName;
  VoidCallback next;
  StoryViewVideo({
    Key? key,
    required this.initSeconds,
    required this.userName,
    required this.link,
    required this.pausePlay,
    required this.next,
  }) : super(key: key);

  @override
  State<StoryViewVideo> createState() => _StoryViewVideoState();
}

class _StoryViewVideoState extends State<StoryViewVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.link)
      ..initialize().then((_) {
        _controller.setVolume(1);
        _controller.play();
        widget.initSeconds(_controller.value.duration.inMilliseconds);

        setState(() {});
      });
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        widget.next();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
  }

  pauseVideo() {
    _controller.pause();
    widget.pausePlay(_controller.value.position.inMilliseconds);
  }

  playVideo() {
    _controller.play();
    widget.pausePlay(null);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_controller.value.isInitialized) {
      return Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Center(
            child: Stack(
              //This will help to expand video in Horizontal mode till last pixel of screen
              fit: StackFit.expand,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    backgroundColor: ColorManager.primary,
                    onPressed: () {
                      if (_controller.value.isPlaying) {
                        pauseVideo();
                      } else {
                        playVideo();
                      }

                      setState(() {});
                    },
                    child: Icon(_controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
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
                            bool purchased =
                                Get.find<UserController>().purchased;
                            if (!purchased) {
                              Get.find<AdsController>().createInterstitialAd();
                            }
                            if (!purchased) {
                              pauseVideo();
                              Get.dialog(Material(
                                  color: Colors.transparent,
                                  child: PremiumGlass()));
                            } else {
                              Get.showOverlay(
                                  asyncFunction: () async {
                                    await GallerySaver()
                                        .saveVideo(widget.link)
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
                                  pauseVideo();
                                  await Get.put(ProfileController())
                                      .getPostUser(widget.userName)
                                      .then((value) {
                                    Get.to(UserProfile(
                                      fromStory: true,
                                    ));
                                    Get.find<UserController>()
                                        .changeTabOpen(false);
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
              ))
        ],
      );
    }
    return Container();
  }
}
