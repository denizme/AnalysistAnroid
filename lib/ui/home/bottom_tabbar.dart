import 'package:admost_flutter_plugin/admost_banner_size.dart';
import 'package:analysist/services/remote_config.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconly/iconly.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/images.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/ui/home/home_controller.dart';
import '../../core/styles_manager.dart';
import '../../widgets/banner.dart';

class BottomTabBar extends GetWidget<HomeController> {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          color: ColorManager.secondary,
          child: Column(
            children: [
              GetBuilder<UserController>(builder: (controller) {
                return RemoteConfigService().bannerActive &&
                        !controller.purchased &&
                        controller.activeBanner
                    ? Container(
                        margin: EdgeInsets.only(
                          top: getVerticalSize(0),
                          bottom: getVerticalSize(0),
                        ),
                        child: BannerAdWidget(AdmostBannerSize.BANNER))
                    : Container(
                        margin: EdgeInsets.only(
                          top: getVerticalSize(0),
                          bottom: getVerticalSize(0),
                        ),
                      );
              }),
              Obx(() => Get.find<UserController>().tabOpen.value
                  ? TabBar(
                      indicatorColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.label,
                      controller: controller.tabController,
                      tabs: RemoteConfigService().messagesActive
                          ? [
                              tabWidget(translate('Home'), 1,
                                  controller.currentIndex.value),
                              tabWidget(translate('Statistics'), 2,
                                  controller.currentIndex.value),
                              tabWidget(translate("Search"), 3,
                                  controller.currentIndex.value),
                              tabWidget(translate("Messages"), 4,
                                  controller.currentIndex.value),
                              tabWidget(translate("Settings"), 5,
                                  controller.currentIndex.value),
                            ]
                          : [
                              tabWidget(translate('Home'), 1,
                                  controller.currentIndex.value),
                              tabWidget(translate('Statistics'), 2,
                                  controller.currentIndex.value),
                              tabWidget(translate("Search"), 3,
                                  controller.currentIndex.value),
                              tabWidget(translate("Settings"), 4,
                                  controller.currentIndex.value),
                            ],
                    )
                  : Container()),
            ],
          )),
    );
  }

  Widget tabWidget(String text, int index, int currentIndex) {
    return Container(
        padding: EdgeInsets.only(
          bottom: getVerticalSize(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                  color: index == currentIndex
                      ? ColorManager.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
            ),
            SizedBox(
              height: getVerticalSize(8),
            ),
            Image.asset(
              RemoteConfigService().messagesActive
                  ? "${ImageConstant.imagePath}/bottom/$index.png"
                  : index == 4
                      ? "${ImageConstant.imagePath}/bottom/5.png"
                      : "${ImageConstant.imagePath}/bottom/$index.png",
              width: 25,
              color: ColorManager.primary,
              height: 25,
            ),
            SizedBox(
              height: getVerticalSize(10),
            ),
            Text(
              text,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: index != currentIndex
                  ? getMediumStyle(color: ColorManager.primary, fontSize: 9)
                  : getBoldStyle(color: ColorManager.primary, fontSize: 9),
            ),
          ],
        ));
  }
}
