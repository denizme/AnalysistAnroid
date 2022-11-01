import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/stories/stories_controller.dart';
import 'package:analysist/ui/stories/story_page.dart';
import '../../models/Stories.dart';
import '../../widgets/loading_widget.dart';

class StoryViewPage extends StatelessWidget {
  dynamic reelId;
  User user;
  List<Item>? items;

  StoryViewPage({required this.reelId, this.items, required this.user});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoriesController>(builder: (controller) {
      if (items != null) {
        controller.getStory(reelId);
      }

      return WillPopScope(
        onWillPop: () {
          Get.find<UserController>().changeTabOpen(true);
          Get.find<UserController>().changeHideBanner(true);
          return Future.value(true);
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              items != null
                  ? StoryPage(
                      items: items!,
                      title: user.username!,
                      userImage: user.profilePicUrl!,
                    )
                  : controller.fetchedStory == null
                      ? Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: loading(ColorManager.primary, 200),
                          ),
                        )
                      : StoryPage(
                          items: controller.fetchedStory!.items!,
                          title: user.username!,
                          userImage: user.profilePicUrl!,
                        ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 15, right: 0),
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Get.find<UserController>().changeTabOpen(true);
                      Get.find<UserController>().changeHideBanner(true);
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      size: 22,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      );
    });
  }
}
