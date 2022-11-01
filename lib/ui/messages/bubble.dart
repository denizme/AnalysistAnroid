import 'package:bubble/bubble.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/models/Messages.dart';
import 'package:analysist/models/PostUser.dart';
import 'package:analysist/ui/landing/user_controller.dart';

import '../profile/user_post.dart';

class MessageBubble extends StatelessWidget {
  Item item;
  Thread thread;
  MessageBubble({Key? key, required this.item, required this.thread})
      : super(key: key);
  int carouselIndex = 0;
  @override
  Widget build(BuildContext context) {
    print(item.itemType);
    if (item.userId.toString() ==
        Get.find<UserController>().choosenAccount!.userId) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.centerRight,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (item.itemType == 'clip') {
                  Get.to(
                      () => UserPost(
                            displayUrl: item
                                .clip['clip']['image_versions2']['candidates']
                                .first['url'],
                            isVideo:
                                item.clip['clip']['video_versions'] != null,
                            videoUrl:
                                item.clip['clip']['video_versions'] != null
                                    ? item.clip['clip']['video_versions']
                                        .first['url']
                                    : null,
                          ),
                      opaque: false,
                      popGesture: false,
                      fullscreenDialog: true);
                } else if (item.itemType == 'media') {
                  Get.to(
                      () => UserPost(
                            displayUrl: item
                                .media['image_versions2']['candidates']
                                .first['url'],
                            isVideo: item.media['video_versions'] != null,
                            videoUrl: item.media['video_versions'] != null
                                ? item.media['video_versions'].first['url']
                                : null,
                          ),
                      opaque: false,
                      popGesture: false,
                      fullscreenDialog: true);
                } else if (item.itemType == 'media_share') {
                  if (item.media_share['carousel_media'] == null) {
                    Get.to(
                        () => UserPost(
                              displayUrl: item
                                  .media_share['image_versions2']['candidates']
                                  .first['url'],
                              isVideo:
                                  item.media_share['video_versions'] != null,
                            ),
                        opaque: false,
                        fullscreenDialog: true);
                  } else {
                    Get.to(
                        () => UserPost(
                              displayUrl: item
                                  .media_share['carousel_media'][carouselIndex]
                                      ['image_versions2']['candidates']
                                  .first['url'],
                              isVideo: item.media_share['carousel_media']
                                      [carouselIndex]['video_versions'] !=
                                  null,
                            ),
                        opaque: false,
                        fullscreenDialog: true);
                  }
                }
              },
              onLongPressStart: (s) {
                if (item.itemType == 'clip') {
                  Get.to(
                      () => UserPost(
                            displayUrl: item
                                .clip['clip']['image_versions2']['candidates']
                                .first['url'],
                            isVideo:
                                item.clip['clip']['video_versions'] != null,
                          ),
                      opaque: false,
                      fullscreenDialog: true);
                } else if (item.itemType == 'media') {
                  Get.to(
                      () => UserPost(
                            displayUrl: item
                                .media['image_versions2']['candidates']
                                .first['url'],
                            isVideo:
                                item.clip['clip']['video_versions'] != null,
                          ),
                      opaque: false,
                      fullscreenDialog: true);
                }
              },
              onLongPressEnd: (s) {
                Get.back();
              },
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: size.height / 2, maxWidth: size.width * 0.7),
                child: Bubble(
                  margin: BubbleEdges.only(left: getHorizontalSize(40)),
                  stick: true,
                  shadowColor: Colors.transparent,
                  nip: BubbleNip.no,
                  radius: Radius.circular(25),
                  padding: BubbleEdges.all(13),
                  color: Color(0xff4d83d7),
                  child: item.itemType == "clip"
                      ? Container(
                          constraints:
                              BoxConstraints(maxHeight: size.height / 2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(item
                                .clip['clip']['image_versions2']['candidates']
                                .first['url']),
                          ),
                        )
                      : item.itemType == "media"
                          ? Container(
                              constraints:
                                  BoxConstraints(maxHeight: size.height / 2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(item
                                    .media['image_versions2']['candidates']
                                    .first['url']),
                              ),
                            )
                          : item.itemType == "media_share"
                              ? Container(
                                  constraints: BoxConstraints(
                                      maxHeight: size.height / 2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item
                                          .media_share['image_versions2']
                                              ['candidates']
                                          .first['url'],
                                    ),
                                  ),
                                )
                              : Text(
                                  item.itemType == "video_call_event"
                                      ? item.videoCallEvent!.description
                                      : item.itemType == "voice_media"
                                          ? "Ses"
                                          : item.itemType == "reel_share"
                                              ? item.reelshare['text']
                                              : item.itemType == "link"
                                                  ? item.link['text']
                                                  : item.text,
                                  style: getMediumStyle(color: Colors.white),
                                  textAlign: TextAlign.left),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      if (item.itemType == 'action_log') {
        return Container();
      }
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.centerLeft,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            CircleAvatar(
              radius: 17,
              backgroundImage: NetworkImage(thread.users![0].profilePicUrl!),
            ),
            GestureDetector(
              onTap: () {
                if (item.itemType == 'clip') {
                  Get.to(
                      () => UserPost(
                            displayUrl: item
                                .clip['clip']['image_versions2']['candidates']
                                .first['url'],
                            isVideo:
                                item.clip['clip']['video_versions'] != null,
                            videoUrl:
                                item.clip['clip']['video_versions'] != null
                                    ? item.clip['clip']['video_versions']
                                        .first['url']
                                    : null,
                          ),
                      opaque: false,
                      popGesture: false,
                      fullscreenDialog: true);
                } else if (item.itemType == 'media') {
                  Get.to(
                      () => UserPost(
                            displayUrl: item
                                .media['image_versions2']['candidates']
                                .first['url'],
                            isVideo: item.media['video_versions'] != null,
                            videoUrl: item.media['video_versions'] != null
                                ? item.media['video_versions'].first['url']
                                : null,
                          ),
                      opaque: false,
                      popGesture: false,
                      fullscreenDialog: true);
                } else if (item.itemType == 'media_share') {
                  if (item.media_share['carousel_media'] == null) {
                    Get.to(
                        () => UserPost(
                              displayUrl: item
                                  .media_share['image_versions2']['candidates']
                                  .first['url'],
                              isVideo:
                                  item.media_share['video_versions'] != null,
                            ),
                        opaque: false,
                        fullscreenDialog: true);
                  } else {
                    Get.to(
                        () => UserPost(
                              displayUrl: item
                                  .media_share['carousel_media'][carouselIndex]
                                      ['image_versions2']['candidates']
                                  .first['url'],
                              isVideo: item.media_share['carousel_media']
                                      [carouselIndex]['video_versions'] !=
                                  null,
                            ),
                        opaque: false,
                        fullscreenDialog: true);
                  }
                }
              },
              onLongPressStart: (s) {
                if (item.itemType == 'clip') {
                  Get.to(
                      () => UserPost(
                            displayUrl: item
                                .clip['clip']['image_versions2']['candidates']
                                .first['url'],
                            isVideo:
                                item.clip['clip']['video_versions'] != null,
                          ),
                      opaque: false,
                      fullscreenDialog: true);
                } else if (item.itemType == 'media') {
                  Get.to(
                      () => UserPost(
                            displayUrl: item
                                .media['image_versions2']['candidates']
                                .first['url'],
                            isVideo:
                                item.clip['clip']['video_versions'] != null,
                          ),
                      opaque: false,
                      fullscreenDialog: true);
                }
              },
              onLongPressEnd: (s) {
                Get.back();
              },
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: size.height / 2, maxWidth: size.width * 0.7),
                child: Bubble(
                  margin: BubbleEdges.only(left: getHorizontalSize(40)),
                  stick: true,
                  shadowColor: Colors.transparent,
                  nip: BubbleNip.no,
                  radius: Radius.circular(25),
                  padding: BubbleEdges.all(13),
                  color: Color(0xff973abf),
                  child: item.itemType == "clip"
                      ? Container(
                          constraints:
                              BoxConstraints(maxHeight: size.height / 2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(item
                                .clip['clip']['image_versions2']['candidates']
                                .first['url']),
                          ),
                        )
                      : item.itemType == "media"
                          ? Container(
                              constraints:
                                  BoxConstraints(maxHeight: size.height / 2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(item
                                    .media['image_versions2']['candidates']
                                    .first['url']),
                              ),
                            )
                          : item.itemType == "media_share"
                              ? item.media_share['carousel_media'] == null
                                  ? Container(
                                      constraints: BoxConstraints(
                                          maxHeight: size.height / 2),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.network(item
                                            .media_share['image_versions2']
                                                ['candidates']
                                            .first['url']),
                                      ),
                                    )
                                  : Container(
                                      constraints: BoxConstraints(
                                          maxHeight: size.height / 2),
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                            viewportFraction: 1,
                                            height: size.height / 3.5,
                                            onPageChanged: (int index, c) {
                                              carouselIndex = index;
                                            }),
                                        items: item
                                            .media_share['carousel_media']
                                            .map<Widget>(
                                              (media) => ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  media['image_versions2']
                                                          ['candidates']
                                                      .first['url'],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )
                              : Text(
                                  item.itemType == "video_call_event"
                                      ? item.videoCallEvent!.description!
                                      : item.itemType == "reel_share"
                                          ? item.reelshare['text']
                                          : item.itemType == "link"
                                              ? item.link['text']
                                              : item.text,
                                  style: getMediumStyle(color: Colors.white),
                                  textAlign: TextAlign.left),
                ),
              ),
            ),
            item.itemType == "clip" &&
                    item.clip['clip']['video_versions'] != null
                ? Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 25),
                    child: Icon(
                      IconlyBold.video,
                      size: 30,
                      color: Colors.white,
                    ))
                : Container(),
          ],
        ),
      );
    }
  }
}
