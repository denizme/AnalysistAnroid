import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/models/Stories.dart';
import 'package:analysist/ui/stories/story_view_image.dart';
import 'package:analysist/ui/stories/story_view_video.dart';
import 'package:analysist/widgets/loading_widget.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

import '../../core/gallery_saver.dart';
import '../../core/show_toast.dart';
import '../../widgets/premium_glass.dart';
import '../home/ads_controller.dart';
import '../landing/user_controller.dart';
import '../profile/profile_controller.dart';
import '../profile/user_profile.dart';

class StoryPage extends StatefulWidget {
  List<Item> items;
  String userImage;
  String title;
  StoryPage(
      {required this.items, required this.title, required this.userImage});
  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage>
    with SingleTickerProviderStateMixin {
  // List<String> links;

  late PageController pageController;
  int currentPage = 0;
  AnimationController? controller;
  Animation? valueAnimation;
  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.toInt();
      });
    });
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    valueAnimation = Tween<double>(begin: 0, end: 1).animate(controller!)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    super.initState();
  }

  int? pauseValue;
  @override
  void dispose() {
    pageController.dispose();
    controller!.dispose();
    super.dispose();
  }

  Timer? t;
  int? duration;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.find<UserController>().changeTabOpen(true);
        Get.find<UserController>().changeHideBanner(true);
        return Future.value(true);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.black])),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    print(details.globalPosition.dx);
                    var x = details.globalPosition.dx;
                    Size size = MediaQuery.of(context).size;
                    // if x is less than halfway across the screen and user is not on first page
                    if (x < size.width / 2) {
                      if (currentPage != 0) {
                        setState(() {
                          duration = null;
                        });
                        pageController.previousPage(
                            duration: Duration(milliseconds: 50),
                            curve: Curves.decelerate);
                        controller!.forward(from: 0);
                        if (t != null) {
                          t!.cancel();
                        }
                      }
                    } else {
                      if (currentPage == widget.items.length - 1) {
                      } else {
                        setState(() {
                          duration = null;
                        });
                        pageController.nextPage(
                            duration: Duration(milliseconds: 50),
                            curve: Curves.decelerate);

                        controller!.forward(from: 0);
                        if (t != null) {
                          t!.cancel();
                        }
                      }
                    }
                  },
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        Item video = widget.items[index];
                        if (video.videoVersions.isNotEmpty) {
                          return StoryViewVideo(
                            pausePlay: (int? milliseconds) {
                              setState(() {
                                if (milliseconds != null) {
                                  controller!.stop();
                                } else {
                                  controller!.forward();
                                }
                              });
                            },
                            next: () {
                              if (mounted) {
                                if (currentPage == widget.items.length - 1) {
                                  Get.find<UserController>()
                                      .changeTabOpen(true);
                                  Get.find<UserController>()
                                      .changeHideBanner(true);
                                  Get.back();
                                } else {
                                  setState(() {
                                    duration = null;
                                  });
                                  pageController.nextPage(
                                      duration: Duration(milliseconds: 50),
                                      curve: Curves.decelerate);
                                  controller!.forward(from: 0);
                                }
                              }
                            },
                            initSeconds: (int seconds) {
                              setState(() {
                                duration = seconds;
                                controller!.duration =
                                    Duration(milliseconds: duration!);

                                controller!.forward();
                              });
                            },
                            link: video.videoVersions.first.url,
                            userName: widget.title,
                          );
                        } else {
                          return StoryViewImage(
                              milliseconds: valueAnimation!.value,
                              userName: widget.title,
                              pause: () {
                                setState(() {
                                  controller!.stop();
                                });
                              },
                              play: () {
                                setState(() {
                                  controller!.forward();
                                });
                              },
                              link: video.imageVersions2!.candidates.first.url,
                              next: () async {
                                if (mounted) {
                                  await Future.delayed(
                                          Duration(milliseconds: 100))
                                      .then((value) {
                                    if (mounted) {
                                      if (currentPage ==
                                          widget.items.length - 1) {
                                        Get.find<UserController>()
                                            .changeTabOpen(true);
                                        Get.find<UserController>()
                                            .changeHideBanner(true);
                                        Get.back();
                                      } else {
                                        pageController.nextPage(
                                            duration:
                                                Duration(milliseconds: 50),
                                            curve: Curves.decelerate);
                                        controller!.duration =
                                            Duration(milliseconds: duration!);
                                        controller!.forward(from: 0);
                                        setState(() {
                                          duration = null;
                                        });
                                      }
                                    }

                                    // and later, before the timer goes off...
                                  });
                                }
                                // }
                              },
                              initSeconds: (int milliseconds) async {
                                await Future.delayed(
                                        Duration(milliseconds: 100))
                                    .then(
                                  (value) {
                                    if (mounted) {
                                      setState(() {
                                        duration = milliseconds;
                                        controller!.duration = Duration(
                                            milliseconds: milliseconds);
                                        controller!.forward(from: 0);
                                      });
                                    }
                                  },
                                );
                              });
                        }
                      })),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top:
                        MediaQuery.of(context).padding.top + kToolbarHeight / 5,
                    left: 3,
                    right: 3),
                child: Column(
                  children: [
                    Row(
                        children: widget.items.map((video) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: duration != null &&
                                  currentPage == widget.items.indexOf(video)
                              ? ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: valueAnimation!.value,
                                    minHeight: 2,
                                    backgroundColor: Colors.grey,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    color: Colors.white,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: currentPage <=
                                            widget.items.indexOf(video)
                                        ? 0
                                        : 1,
                                    backgroundColor: Colors.grey,
                                    minHeight: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    }).toList()),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(widget.userImage),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.title,
                            style: getBoldStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
