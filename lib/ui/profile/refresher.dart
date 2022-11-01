import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/ui/profile/profile_controller.dart';
import 'package:loading_progress_indicator/loading_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_beat_progress_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/colors.dart';

class Refresher extends StatelessWidget {
  Widget child;
  String userName;
  String userid;

  Refresher(
      {Key? key,
      required this.child,
      required this.userid,
      required this.userName})
      : super(key: key);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  void onRefresh() async {
    // monitor network fetch
    await Get.find<ProfileController>().getPostUser(userName);
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch

    await Get.find<ProfileController>().getMorePost(userid).then((value) {
      refreshController.twoLevelComplete();
      refreshController.loadComplete();
    });
    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(
          waterDropColor: ColorManager.primary,
          refresh: LoadingProgressIndicator(
              indicator: BallBeatProgressIndicator(),
              size: 50,
              color: Colors.white),
          complete: CircleAvatar(
            radius: 13,
            backgroundColor: ColorManager.primary,
            child: Icon(Icons.check, size: 20, color: ColorManager.lightWhite),
          ),
        ),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Container();
            } else if (mode == LoadStatus.loading) {
              body = LoadingProgressIndicator(
                  indicator: BallBeatProgressIndicator(),
                  size: 50,
                  color: Colors.white);
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text(
                "release to load more",
                style: getRegularStyle(color: Colors.white),
              );
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: child);
  }
}
