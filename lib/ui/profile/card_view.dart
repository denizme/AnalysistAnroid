import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/ui/home/ads_controller.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:loading_progress_indicator/loading_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_spin_fade_loader_progress_indicator.dart';
import '../../core/styles_manager.dart';

class CardView extends StatelessWidget {
  String text;
  String count;
  Widget icon;
  Function onTap;
  bool loading;
  CardView(
      {Key? key,
      required this.count,
      required this.onTap,
      required this.text,
      this.loading = false,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: InkWell(
        onTap: () {
          bool purchased = Get.find<UserController>().purchased;
          if (!purchased) {
            Get.find<AdsController>().createInterstitialAd();
          }
          Get.find<UserController>().changeTabOpen(false);
          onTap();
        },
        child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getHorizontalSize(15),
                    vertical: getVerticalSize(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              loading
                                  ? LoadingProgressIndicator(
                                      indicator:
                                          BallSpinFadeLoaderProgressIndicator(),
                                      size: 19,
                                      color: ColorManager.primary)
                                  : Text(
                                      count,
                                      style: getMediumStyle(
                                          color: ColorManager.primary,
                                          fontSize: 23),
                                    ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: getVerticalSize(8),
                          ),
                          Container(
                            child: Text(
                              text,
                              maxLines: 2,
                              style: getRegularStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}
