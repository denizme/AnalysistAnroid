import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/models/Messages.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/messages/bubble.dart';
import 'package:analysist/ui/messages/messages_controller.dart';
import 'package:loading_progress_indicator/loading_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_beat_progress_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../core/styles_manager.dart';
import '../../widgets/premium_glass.dart';

class Detail extends StatelessWidget {
  Thread thread;
  Detail({Key? key, required this.thread}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.find<UserController>().changeTabOpen(true);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 20),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0),
            decoration: BoxDecoration(color: ColorManager.secondary),
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 3),
            child: Row(children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: ColorManager.primary,
                ),
              ),
              SizedBox(
                width: getHorizontalSize(5),
              ),
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(thread.users![0].profilePicUrl!),
              ),
              SizedBox(
                width: getHorizontalSize(8),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    thread.users![0].fullName == null ||
                            thread.users![0].fullName == ''
                        ? thread.users![0].username!
                        : thread.users![0].fullName!,
                    style:
                        getBoldStyle(color: ColorManager.primary, fontSize: 12),
                  ),
                  SizedBox(
                    height: getVerticalSize(4),
                  ),
                  Text(
                    thread.users![0].fullName == null ||
                            thread.users![0].fullName == ''
                        ? thread.users![0].username!
                        : thread.users![0].username!,
                    style: getRegularStyle(
                        color: ColorManager.primary, fontSize: 10),
                  ),
                ],
              ),
              Spacer(),
            ]),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: ColorManager.secondary),
          child: GetBuilder<MessagesController>(builder: (controller) {
            return Column(
              children: [
                Expanded(
                  child: SmartRefresher(
                    enablePullDown: Get.find<UserController>().purchased,
                    enablePullUp: Get.find<UserController>().purchased,
                    header: WaterDropHeader(
                      waterDropColor: ColorManager.primary,
                      refresh: LoadingProgressIndicator(
                          indicator: BallBeatProgressIndicator(),
                          size: 50,
                          color: ColorManager.primary),
                      complete: CircleAvatar(
                        radius: 13,
                        backgroundColor: ColorManager.primary,
                        child: Icon(Icons.check,
                            size: 20, color: ColorManager.lightWhite),
                      ),
                    ),
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus? mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Icon(
                            IconlyLight.arrow_up,
                            color: ColorManager.lightWhite,
                          );
                        } else if (mode == LoadStatus.loading) {
                          body = CupertinoActivityIndicator(
                            color: ColorManager.lightWhite,
                          );
                        } else if (mode == LoadStatus.failed) {
                          body = Text("Load Failed!Click retry!");
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text("release to load more",
                              style: getMediumStyle(
                                color: ColorManager.lightWhite,
                              ));
                        } else {
                          body = Text("No more Data");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: controller.refreshController2,
                    onRefresh: controller.onRefresh,
                    onLoading: controller.onLoading,
                    child: Stack(
                      children: [
                        IgnorePointer(
                          ignoring: !Get.find<UserController>().purchased,
                          child: ListView.builder(
                              itemCount: thread.items!.length,
                              reverse: true,
                              padding: EdgeInsets.symmetric(
                                  horizontal: getHorizontalSize(15),
                                  vertical: getVerticalSize(10)),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                Item item = thread.items![index];
                                return MessageBubble(
                                  item: item,
                                  thread: thread,
                                );
                              }),
                        ),
                        PremiumGlass()
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
