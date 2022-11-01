import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/ui/login/login.dart';
import 'package:analysist/ui/login/why_cant_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../services/remote_config.dart';
import '../landing/user_controller.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.find<UserController>().changeTabOpen(true);
        Get.find<UserController>().changeHideBanner(true);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: ColorManager.backgroundColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.top + kToolbarHeight / 5,
                top: MediaQuery.of(context).padding.top + kToolbarHeight / 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width / 2,
                  child: Text(
                    translate("We never keep or share your data"),
                    textAlign: TextAlign.center,
                    style: getMediumStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            width: size.width / 2.5,
                            height: size.width / 2.5,
                          ),
                        ],
                      ),
                      Text(
                        'Analysist',
                        style:
                            getMediumStyle(color: Colors.black, fontSize: 25),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translate("Follower Analyzer For Instagram"),
                        style:
                            getRegularStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: size.height / 6,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ElevatedButton(
                          onPressed: () {
                            final cookieManager = CookieManager();
                            cookieManager.clearCookies();
                            Get.to(() => Login(),
                                transition: Transition.downToUp);
                            Get.to(() => Login(),
                                transition: Transition.downToUp);
                            // Get.bottomSheet(Premium(),
                            //     elevation: 2,
                            //     enableDrag: true,
                            //     persistent: true,
                            //     isDismissible: true,
                            //     isScrollControlled: true,
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.only(
                            //             topLeft: Radius.circular(50),
                            //             topRight: Radius.circular(50))));
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              backgroundColor: Colors.transparent,
                              onPrimary: ColorManager.primary,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: ColorManager.primary, width: 2),
                                  borderRadius: BorderRadius.circular(8))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/instagram.png',
                                  width: 20,
                                  height: 20,
                                  color: ColorManager.primary),
                              SizedBox(
                                width: getHorizontalSize(10),
                              ),
                              Text(
                                translate("Login With Instagram"),
                                style: getBoldStyle(
                                    color: ColorManager.primary, fontSize: 15),
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 18,
                          color: ColorManager.primary,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          translate("Your Instagram account is safe with us"),
                          style: getRegularStyle(
                              color: ColorManager.primary, fontSize: 11),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getVerticalSize(8),
                    ),
                    InkWell(
                      onTap: () {
                        String privacyPolicy =
                            RemoteConfigService().privacyPolicy;
                        launchUrl(Uri.parse(privacyPolicy));
                      },
                      child: Container(
                        width: size.width / 1.2,
                        child: Text(
                          translate(
                              "You accept our privacy policy and use of terms when you log in"),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              color: Colors.grey,
                              fontSize: 10,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
