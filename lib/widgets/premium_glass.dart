import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/ui/landing/user_controller.dart';

import '../core/math_utils.dart';
import '../core/styles_manager.dart';
import '../ui/premium/premium.dart';

class PremiumGlass extends StatelessWidget {
  const PremiumGlass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      if (controller.purchased) {
        return Container();
      }
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 11.0,
          sigmaY: 11.0,
        ),
        child: Center(
            child: Container(
          decoration: BoxDecoration(
              color: ColorManager.secondary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(
              horizontal: getHorizontalSize(20), vertical: getVerticalSize(12)),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: EdgeInsets.only(top: getVerticalSize(0)),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  previliges(Icons.ad_units, translate('Remove Ads')),
                  previliges(
                    Icons.group,
                    translate('Add Multi Account'),
                  ),
                  previliges(
                    Icons.pages,
                    translate('Access All Pages'),
                  ),
                  previliges(Icons.block, translate('See who blocked you')),
                  previliges(
                    Icons.message_rounded,
                    translate(
                      'View Messages Secretly',
                    ),
                  ),
                  previliges(Icons.insert_chart,
                      translate('Analyze Whole Your Instagram')),
                  previliges(
                    Icons.download,
                    translate('Download Posts Profile Photos And Stories'),
                  ),
                  previliges(
                      Icons.notification_add,
                      translate(
                        'Get Notified When Someone Unfollows You',
                      )),
                  SizedBox(
                    height: getVerticalSize(5),
                  ),
                  Container(
                    width: getHorizontalSize(220),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.secondary,
                          onPrimary: ColorManager.primary,
                        ),
                        onPressed: () {
                          Get.bottomSheet(Premium(),
                              elevation: 2,
                              enableDrag: true,
                              persistent: true,
                              isDismissible: true,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))));
                          Get.find<UserController>().changeTabOpen(false);
                          Get.find<UserController>().changeHideBanner(false);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/premium.png',
                              color: ColorManager.primary,
                              width: 22,
                              height: 22,
                            ),
                            SizedBox(
                              width: getHorizontalSize(10),
                            ),
                            Text(
                              translate("Go Premium Now"),
                              style: getBoldStyle(
                                  color: ColorManager.primary, fontSize: 14),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: getVerticalSize(3),
                  ),
                ],
              ),
            ],
          ),
        ).asGlass(
                blurX: 20,
                blurY: 20,
                tintColor: ColorManager.primary,
                clipBorderRadius: BorderRadius.circular(10))),
      );
    });
  }

  Widget previliges(IconData icon, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getVerticalSize(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 18,
            color: ColorManager.primary,
          ),
          SizedBox(
            width: getHorizontalSize(8),
          ),
          Container(
            width: getHorizontalSize(200),
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: getRegularStyle(color: ColorManager.primary, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
