import 'dart:ui';
import 'package:analysist/services/remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:analysist/core/boxes.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/models/Account.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/login/welcome.dart';
import 'package:analysist/ui/premium/premium.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/show_info_dialog.dart';

class MenuDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GetBuilder<UserController>(builder: (controller) {
        return Container(
          width: MediaQuery.of(context).size.width / 1.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [ColorManager.primary, ColorManager.secondary])),
          child: Padding(
            // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            padding: EdgeInsets.only(top: 0),
            child: Material(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    side:
                        BorderSide(color: ColorManager.lightWhite, width: 0.25),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 10, top: MediaQuery.of(context).padding.top + 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: getHorizontalSize(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                "assets/images/menu.png",
                                width: 20,
                                height: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: getHorizontalSize(35),
                            ),
                            Text(
                              controller.user!.user.username,
                              style: getRegularStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(
                              width: getHorizontalSize(5),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Icon(
                                IconlyBold.arrow_down_2,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: getVerticalSize(15),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: getHorizontalSize(25),
                        ),
                        child: Row(
                          children: [
                            OutlineGradientButton(
                              padding: EdgeInsets.all(1.5),
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.white]),
                              strokeWidth: 3,
                              radius: Radius.circular(50),
                              child: controller.user == null
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: CircleAvatar(
                                        radius: 27.5,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 27.5,
                                      backgroundImage: NetworkImage(controller
                                          .user!.user.profilePicUrl!)),
                            ),
                            SizedBox(
                              width: getHorizontalSize(15),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(Welcome(),
                                    transition: Transition.downToUp);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white.withOpacity(1),
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.zero),
                              child: CircleAvatar(
                                radius: 27.5,
                                backgroundColor: Colors.white.withOpacity(0.1),
                                child: Icon(
                                  IconlyBold.add_user,
                                  color: ColorManager.secondary,
                                  size: 27,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHorizontalSize(10),
                      ),

                      Divider(
                        color: ColorManager.lightWhite,
                        thickness: 0.2,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => Premium());
                          },
                          focusColor: Colors.white,
                          splashColor: Colors.white,
                          overlayColor:
                              MaterialStateProperty.resolveWith((states) {
                            // If the button is pressed, return green, otherwise blue
                            if (states.contains(MaterialState.pressed)) {
                              return ColorManager.secondary;
                            }
                            return ColorManager.primary;
                          }),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: getHorizontalSize(25),
                                top: getVerticalSize(8),
                                bottom: getVerticalSize(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/premium.png",
                                  width: 24,
                                  height: 24,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: getHorizontalSize(20),
                                ),
                                Text(
                                  translate("Go Premium"),
                                  style: getRegularStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: ColorManager.lightWhite,
                        thickness: 0.2,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Share.share(appLink);
                          },
                          focusColor: Colors.white,
                          splashColor: Colors.white,
                          overlayColor:
                              MaterialStateProperty.resolveWith((states) {
                            // If the button is pressed, return green, otherwise blue
                            if (states.contains(MaterialState.pressed)) {
                              return ColorManager.secondary;
                            }
                            return ColorManager.primary;
                          }),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: getHorizontalSize(25),
                                top: getVerticalSize(8),
                                bottom: getVerticalSize(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.share_solid,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: getHorizontalSize(20),
                                ),
                                Text(
                                  translate("Share App"),
                                  style: getRegularStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: ColorManager.lightWhite,
                        thickness: 0.2,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            try {
                              final InAppReview inAppReview =
                                  InAppReview.instance;

                              if (await inAppReview.isAvailable()) {
                                await inAppReview.requestReview();
                                inAppReview.openStoreListing();
                              } else {
                                launchUrl(Uri.parse(appLink));
                              }
                            } catch (e) {
                              launchUrl(Uri.parse(appLink));
                            }
                          },
                          focusColor: Colors.white,
                          splashColor: Colors.white,
                          overlayColor:
                              MaterialStateProperty.resolveWith((states) {
                            // If the button is pressed, return green, otherwise blue
                            if (states.contains(MaterialState.pressed)) {
                              return ColorManager.secondary;
                            }
                            return ColorManager.primary;
                          }),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: getHorizontalSize(25),
                                top: getVerticalSize(8),
                                bottom: getVerticalSize(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.star_fill,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: getHorizontalSize(20),
                                ),
                                Text(
                                  translate("Rate Us"),
                                  style: getRegularStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: ColorManager.lightWhite,
                        thickness: 0.2,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            String privacyPolicy =
                                RemoteConfigService().privacyPolicy;
                            launchUrl(Uri.parse(privacyPolicy));
                          },
                          focusColor: Colors.white,
                          splashColor: Colors.white,
                          overlayColor:
                              MaterialStateProperty.resolveWith((states) {
                            // If the button is pressed, return green, otherwise blue
                            if (states.contains(MaterialState.pressed)) {
                              return ColorManager.secondary;
                            }
                            return ColorManager.primary;
                          }),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: getHorizontalSize(25),
                                top: getVerticalSize(8),
                                bottom: getVerticalSize(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.privacy_tip,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: getHorizontalSize(20),
                                ),
                                Text(
                                  translate("Privacy Policy"),
                                  style: getRegularStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: ColorManager.lightWhite,
                        thickness: 0.2,
                      ),
                      InkWell(
                        onTap: () {
                          showInfoDialog(context, translate("Log Out"),
                              translate('Are you sure want to log out?'), () {
                            final accountBox = Boxes.getAccounts();
                            Account? account =
                                Get.find<UserController>().choosenAccount;
                            accountBox.delete(account!.userId);

                            Get.to(Welcome(), transition: Transition.downToUp);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: getHorizontalSize(25),
                              top: getVerticalSize(8),
                              bottom: getVerticalSize(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(
                                width: getHorizontalSize(20),
                              ),
                              Text(
                                translate(
                                  "Log Out",
                                ),
                                style: getRegularStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ListTile(
                      //   leading: CircleAvatar(child: Icon(IconlyBold.game)),
                      // )
                    ],
                  ),
                )),
          ),
        );
      }),
    );
  }
}

showMenuDialog() {
  Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black38,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (ctx, anim1, anim2) => MenuDialog(),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
            child: SlideTransition(
              position:
                  Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(anim1),
              child: child,
            ),
          ));
}
