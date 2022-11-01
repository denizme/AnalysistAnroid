import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/ui/stories/empty_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:analysist/ui/stories/stories_controller.dart';
import 'package:analysist/ui/stories/story_item.dart';

import '../../core/constants.dart';
import '../../core/styles_manager.dart';
import '../../models/Stories.dart';

class StoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoriesController>(builder: (controller) {
      controller.fetchedStories
          .sort((a, b) => a.watched.toString().compareTo(b.watched.toString()));

      return Container(
        child: Column(
          children: [
            controller.fetchedStories.isNotEmpty
                ? Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate('Watch Stories Secretly'),
                          style: getMediumStyle(
                              color: ColorManager.primary, fontSize: 13),
                        ),
                        controller.myStoryViews.isEmpty
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      translate(
                                        "Story Views",
                                      ),
                                      style: getRegularStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                    SizedBox(
                                      width: getHorizontalSize(5),
                                    ),
                                    Text(
                                      controller.myStoryViews
                                          .map((element) =>
                                              element.totalViewerCount)
                                          .toString(),
                                      style: getRegularStyle(
                                          color: Colors.white, fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                      ],
                    ),
                  )
                : Container(),
            Container(
              height: controller.fetchedStories.isEmpty && controller.loaded
                  ? 0
                  : 80,
              child: controller.loaded == false
                  ? ListView.builder(
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return EmptyItem(
                          index: index,
                          length: controller.fetchedStories.length,
                        );
                      })
                  : ListView.builder(
                      itemCount: controller.fetchedStories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Stories story = controller.fetchedStories[index];
                        return StoryItem(
                          story: story,
                          index: index,
                          length: controller.fetchedStories.length,
                        );
                      }),
            ),
          ],
        ),
      );
    });
  }
}
