import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/models/Messages.dart';
import 'package:analysist/ui/messages/empty_item.dart';
import 'package:analysist/ui/messages/item.dart';
import 'package:analysist/ui/messages/messages_controller.dart';
import 'package:loading_progress_indicator/loading_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_beat_progress_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../core/constants.dart';
import '../../core/styles_manager.dart';
import '../../widgets/lottie.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(MessagesController());
    return GetBuilder<MessagesController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropHeader(
                waterDropColor: ColorManager.primary,
                refresh: LoadingProgressIndicator(
                    indicator: BallBeatProgressIndicator(),
                    size: 50,
                    color: Colors.white),
                complete: CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.white,
                  child:
                      Icon(Icons.check, size: 20, color: ColorManager.primary),
                ),
              ),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: controller.refreshController,
              onRefresh: controller.onRefresh,
              onLoading: controller.onLoading,
              child: SingleChildScrollView(
                child: Container(
                    height: controller.loaded == false ||
                            controller.fetchedMessages == null
                        ? size.height - (kToolbarHeight + getVerticalSize(200))
                        : controller.fetchedMessages!.inbox!.threads!.length *
                                97 +
                            50,
                    padding:
                        EdgeInsets.symmetric(horizontal: getHorizontalSize(15)),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            translate('View Messages Secretly'),
                            style: getMediumStyle(
                                color: ColorManager.primary, fontSize: 13),
                          ),
                        ),
                        controller.fetchedMessages == null
                            ? controller.loaded
                                ? Expanded(
                                    child: Center(
                                      child: LottiePage(
                                          width: double.infinity,
                                          heigth: double.infinity,
                                          lottie: 'no-data'),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.separated(
                                        itemCount: 10,
                                        separatorBuilder: (context, index) =>
                                            Divider(),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return EmptyItem();
                                        }),
                                  )
                            : Expanded(
                                child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Divider(),
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    itemCount: controller.fetchedMessages!
                                        .inbox!.threads!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      Thread? thread = controller
                                          .fetchedMessages!
                                          .inbox!
                                          .threads![index];
                                      if (thread == null) {
                                        return Container();
                                      }
                                      return MessageItem(
                                        index: index,
                                      );
                                    }),
                              )
                      ],
                    )),
              )),
        );
      },
    );
  }
}
