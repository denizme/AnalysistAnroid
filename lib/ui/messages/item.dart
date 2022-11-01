import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/models/Messages.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/messages/messages_controller.dart';
import 'package:shimmer/shimmer.dart';

import 'detail.dart';

class MessageItem extends StatelessWidget {
  int index;
  MessageItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      child: GetBuilder<MessagesController>(builder: (controller) {
        Thread thread = controller.fetchedMessages!.inbox!.threads![index];
        return InkWell(
          onTap: () {
            Get.to(
                () => Detail(
                      thread: thread,
                    ),
                transition: Transition.rightToLeftWithFade);
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(180)),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(controller.fetchedMessages!
                        .inbox!.threads![index].users![0].profilePicUrl!),
                  ),
                  title: Text(
                    thread.users![0].fullName == null ||
                            thread.users![0].fullName == ''
                        ? thread.users![0].username!
                        : thread.users![0].fullName!,
                    style: getMediumStyle(color: Colors.black, fontSize: 13),
                  ),
                  subtitle: Text(
                    thread.items!.first.itemType == "link"
                        ? thread.items!.first.link['text']
                        : thread.items!.first.itemType == 'reel_share'
                            ? thread.items!.first.reelshare['text']
                            : thread.items!.first.itemType == 'action_log'
                                ? thread.items!.first.actionlog['description']
                                : thread.items!.first.itemType == 'clip'
                                    ? controller
                                                    .fetchedMessages!
                                                    .inbox!
                                                    .threads![index]
                                                    .items!
                                                    .first
                                                    .clip['clip']
                                                ['video_versions'] !=
                                            null
                                        // ignore: prefer_interpolation_to_compose_strings
                                        ? "🎥 " +
                                            controller
                                                .fetchedMessages!
                                                .inbox!
                                                .threads![index]
                                                .items!
                                                .first
                                                .clip['clip']['caption']['text']
                                        // ignore: prefer_interpolation_to_compose_strings
                                        : "📷 " +
                                            controller
                                                .fetchedMessages!
                                                .inbox!
                                                .threads![index]
                                                .items!
                                                .first
                                                .clip['clip']['caption']['text']
                                    : thread.items!.first.itemType ==
                                            "video_call_event"
                                        ? thread.items!.first.videoCallEvent!
                                            .description!
                                        : thread.items!.first.text == null
                                            ? ''
                                            : thread.items!.first.text!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getRegularStyle(color: Colors.black, fontSize: 11),
                  ),

                  // trailing: DateTime.fromMicrosecondsSinceEpoch(
                  //             thread.items!.first.timestamp!)
                  //         .toLocal()
                  //         .difference(DateTime.fromMicrosecondsSinceEpoch(int.parse(
                  //                 thread
                  //                     .lastSeenAt![Get.find<UserController>()
                  //                         .choosenAccount!
                  //                         .userId]!
                  //                     .timestamp!))
                  //             .toLocal())
                  //         .isNegative
                  //     ? Badge(
                  //         toAnimate: false,
                  //         shape: BadgeShape.circle,
                  //         badgeColor: Colors.deepPurple,
                  //         padding: EdgeInsets.all(8),
                  //         borderRadius: BorderRadius.circular(8),
                  //         badgeContent:
                  //             Text("", style: getBoldStyle(color: Colors.white)),
                  //       )
                  //     : null,
                ),
                Padding(
                  padding: EdgeInsets.only(left: getHorizontalSize(65)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(180)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX:
                            Get.find<UserController>().purchased ? 0.0 : 5.0,
                        sigmaY:
                            Get.find<UserController>().purchased ? 0.0 : 5.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(180)),
                        alignment: Alignment.bottomCenter,
                        width: double.infinity,
                        height: 32.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
