import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../core/constants.dart';
import '../../../models/PostUser.dart';

class AllPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.find<UserController>().changeTabOpen(true);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.secondary,
          elevation: 2,
          toolbarHeight: kToolbarHeight - 5,
          centerTitle: false,
          shadowColor: Colors.grey.shade200,
          leading: IconButton(
              onPressed: () {
                Get.find<UserController>().changeTabOpen(true);
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: ColorManager.primary,
              )),
          title: Text(translate('Posts'),
              style: getRegularStyle(
                fontSize: 17,
                color: ColorManager.primary,
              )),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(color: ColorManager.secondary),
          child: GetBuilder<UserController>(builder: (controller) {
            return ListView.builder(
                itemCount: controller.postMedias.length,
                itemBuilder: (context, index) {
                  Edge? edge = controller.postMedias[index];
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(
                          horizontal: getHorizontalSize(25)),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(edge!.node!.displayUrl!),
                          ),
                          SizedBox(
                            height: getVerticalSize(15),
                          ),
                          edge.node!.edgeMediaToCaption!.edges!.isEmpty
                              ? Container()
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.closed_caption,
                                        color: ColorManager.primary,
                                        size: 23,
                                      ),
                                      SizedBox(
                                        width: getHorizontalSize(15),
                                      ),
                                      Expanded(
                                        child: Text(
                                          edge.node!.edgeMediaToCaption!.edges!
                                              .map((element) =>
                                                  element['node']['text'])
                                              .toList()
                                              .join('\n'),
                                          textAlign: TextAlign.start,
                                          style: getRegularStyle(
                                              color: ColorManager.primary,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          edge.node!.edgeMediaToCaption!.edges!.isEmpty
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Divider(
                                    color: ColorManager.lightWhite,
                                    thickness: 0.2,
                                  ),
                                ),
                          Row(
                            children: [
                              Icon(
                                Icons.favorite_outline_outlined,
                                color: ColorManager.primary,
                                size: 23,
                              ),
                              SizedBox(
                                width: getHorizontalSize(15),
                              ),
                              Text(
                                "${edge.node!.edgeMediaPreviewLike!.count} Beğeni",
                                style: getRegularStyle(
                                    color: ColorManager.primary, fontSize: 13),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 6),
                            child: Divider(
                              color: ColorManager.lightWhite,
                              thickness: 0.2,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.comment_outlined,
                                color: ColorManager.primary,
                                size: 23,
                              ),
                              SizedBox(
                                width: getHorizontalSize(15),
                              ),
                              Text(
                                "${edge.node!.edgeMediaToComment!.count} Yorum",
                                style: getRegularStyle(
                                    color: ColorManager.primary, fontSize: 13),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              color: ColorManager.lightWhite,
                              thickness: 0.2,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: ColorManager.primary,
                                size: 23,
                              ),
                              SizedBox(
                                width: getHorizontalSize(15),
                              ),
                              Text(
                                timeago.format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                            (edge.node!.takenAtTimestamp! *
                                                1000))
                                        .toLocal()),
                                style: getRegularStyle(
                                    color: ColorManager.primary, fontSize: 13),
                              )
                            ],
                          )
                        ],
                      ));
                });
          }),
        ),
      ),
    );
  }
}
