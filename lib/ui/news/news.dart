import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/models/News.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/messages/empty_item.dart';
import 'package:analysist/ui/news/new_item.dart';

class NewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        Get.find<UserController>().changeTabOpen(true);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Hareketler'),
          elevation: 0,
        ),
        body: Container(
          child: GetBuilder<UserController>(builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                height: height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      ColorManager.primary,
                      ColorManager.secondary
                    ])),
                child: controller.fecthedNews == null
                    ? Container(
                        height: height,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: getHorizontalSize(25),
                                vertical: getVerticalSize(10)),
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return EmptyItem();
                            }),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: getVerticalSize(10),
                          ),
                          controller.fecthedNews!.newStories == null ||
                                  controller.fecthedNews!.newStories!.isEmpty
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getHorizontalSize(25),
                                  ),
                                  child: Text(
                                    'New',
                                    style: getBoldStyle(color: Colors.white),
                                  ),
                                ),
                          Container(
                            height:
                                controller.fecthedNews!.newStories!.length * 93,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                    horizontal: getHorizontalSize(25),
                                    vertical: getVerticalSize(10)),
                                itemCount:
                                    controller.fecthedNews!.newStories!.length,
                                itemBuilder: (context, index) {
                                  Story story = controller
                                      .fecthedNews!.newStories![index];
                                  return NewItem(story: story);
                                }),
                          ),
                          controller.fecthedNews!.newStories == null ||
                                  controller.fecthedNews!.newStories!.isEmpty
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(25)),
                                  child: Divider(
                                    color: ColorManager.lightWhite,
                                  ),
                                ),
                          Container(
                            height:
                                controller.fecthedNews!.oldStories!.length * 93,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                    horizontal: getHorizontalSize(25),
                                    vertical: getVerticalSize(10)),
                                itemCount:
                                    controller.fecthedNews!.oldStories!.length,
                                itemBuilder: (context, index) {
                                  Story story = controller
                                      .fecthedNews!.oldStories![index];
                                  return NewItem(story: story);
                                }),
                          )
                        ],
                      ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
