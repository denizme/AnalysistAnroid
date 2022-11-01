import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/ui/landing/user_controller.dart';

import '../../../core/constants.dart';
import '../../../models/PostUser.dart';
import '../../../widgets/premium_glass.dart';
import '../../profile/user_post.dart';

class MostLiked extends StatelessWidget {
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
          title: Text(translate('Most Likes'),
              style: getRegularStyle(
                fontSize: 17,
                color: ColorManager.primary,
              )),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(color: ColorManager.secondary),
          child: Stack(
            children: [
              IgnorePointer(
                ignoring: !Get.find<UserController>().purchased,
                child: GetBuilder<UserController>(builder: (controller) {
                  if (controller.mostLikedPost == null) {
                    return Container();
                  }
                  controller.postMedias.sort((a, b) => b!
                      .node!.edgeMediaPreviewLike!.count!
                      .compareTo(a!.node!.edgeMediaPreviewLike!.count!));
                  return GridView.builder(
                      itemCount: controller.postMedias.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        Edge? edge = controller.postMedias[index];

                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => UserPost(
                                displayUrl: edge!.node!.displayUrl!,
                                isVideo: edge.node!.isVideo!,
                                videoUrl: edge.node!.isVideo!
                                    ? edge.node!.videoUrl!
                                    : null,
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            edge!.node!.displayUrl!))),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent,
                                          Colors.transparent,
                                          Colors.transparent,
                                          Colors.black
                                        ])),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: getHorizontalSize(10),
                                    ),
                                    Text(
                                      "${edge.node!.edgeMediaPreviewLike!.count} ${translate("Like")}",
                                      style: getRegularStyle(
                                          color: Colors.white, fontSize: 17),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 3,
                              crossAxisSpacing: 10));
                }),
              ),
              PremiumGlass()
            ],
          ),
        ),
      ),
    );
  }
}
