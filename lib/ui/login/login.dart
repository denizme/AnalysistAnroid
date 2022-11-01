import 'dart:io';
import 'package:analysist/ui/home/home_controller.dart';
import 'package:analysist/ui/login/model_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_cookie/client_cookie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/boxes.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/models/Account.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../core/math_utils.dart';
import '../stories/stories_controller.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cookieManager = WebviewCookieManager();

    final String _url = 'https://youtube.com';
    final String instagram = "https://i.instagram.com/";
    final String instagramwithUser = "https://i.instagram.com/instatest5473";
    final String cookieValue = 'some-cookie-value';
    final String domain = 'youtube.com';
    final String cookieName = 'some_cookie_name';
    loginAccount() async {
      print("On Page finish:");

      final gotCookies = await cookieManager.getCookies(instagram);
      // Initializing a cookie
      final cookie1 = ClientCookie('Client', 'jaguar_resty', DateTime.now());

      // Cookie to header string
      print(cookie1.toReqHeader);
      final accountBox = Boxes.getAccounts();
      String cookie = 'base_domain=.instagram.com;';
      String userId = "";
      String csrfToken = "";
      var sessionId = '';
      var datr = '';
      // Encoding many cookies
      for (var item in gotCookies) {
        if (item.name == "ds_user_id") {
          userId = item.value;
        }
        if (item.name == "x-csrftoken" || item.name == "csrftoken") {
          csrfToken = item.value;
        }
        if (item.name == "sessionid") {
          sessionId = item.value;
        }
        if (item.name == "datr") {
          datr = item.value;
        }
        cookie += (item.name + "=" + item.value + "; ");
      }
      if (userId != "" && sessionId != "") {
        Get.find<UserController>().setAccount(
            Account(userId: userId, cookie: cookie, csrfToken: csrfToken));
        Get.find<UserController>().getInfo().then((value) {
          print('value =====  $value');
          if (value) {
            accountBox.put(userId,
                Account(userId: userId, cookie: cookie, csrfToken: csrfToken));

            Get.back();
            Get.put(StoriesController());
            Get.find<StoriesController>().getStories().then((value) {});
            Get.find<UserController>().getPrefs();
            Get.find<UserController>().changeTabOpen(true);
            Get.find<UserController>().changeHideBanner(true);
          }
        });
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: instagram,
              userAgent:
                  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) async {
                await cookieManager.setCookies([
                  Cookie(cookieName, cookieValue)
                    ..domain = domain
                    ..expires = DateTime.now().add(Duration(days: 10))
                    ..httpOnly = false
                ]);
              },
              onPageStarted: (_) {
                loginAccount();
              },
              onPageFinished: (_) async {
                loginAccount();
              },
            ),
          ),
          Container(
            color: Colors.grey.shade200,
            child: CarouselSlider(
                items: loginModels.map<Widget>((e) {
                  return Container(
                      child: LoginModelItem(
                    loginModel: e,
                  ));
                }).toList(),
                options: CarouselOptions(
                  height: getVerticalSize(150),
                  viewportFraction: 1,
                  initialPage: 0,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 1400),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  onPageChanged: (int page, c) {
                    Get.find<HomeController>().changeLoginPage(page);
                  },
                  scrollDirection: Axis.horizontal,
                )),
          ),
          Container(
            color: Colors.grey.shade200,
            width: double.infinity,
            child: Center(
              child: GetBuilder<HomeController>(builder: (controller) {
                return AnimatedSmoothIndicator(
                  activeIndex: controller.loginPage,
                  count: loginModels.length,
                  effect: WormEffect(
                      spacing: 8.0,
                      radius: 100.0,
                      dotWidth: 7.0,
                      dotHeight: 7.0,
                      paintStyle: PaintingStyle.fill,
                      strokeWidth: 0.5,
                      dotColor: Colors.grey.shade400,
                      activeDotColor: ColorManager.primary),
                );
              }),
            ),
          ),
          Container(
            color: Colors.grey.shade200,
            height: 15,
          )
        ],
      ),
    );
  }

  List<LoginModel> loginModels = [
    LoginModel(
        title: 'High Security',
        body:
            'Analysist never sees or saves your password or private information',
        icon: Icons.safety_check),
    LoginModel(
        title: 'You Are the Only Authorized Person',
        body: 'Analysist never follows or likes without your permission',
        icon: Icons.security),
    LoginModel(
        title: 'Your priority is our priority',
        body: 'Your personal information is protected by high security rules.',
        icon: Icons.account_circle),
    LoginModel(
        title: 'Your Data is Protected',
        body:
            'Your data will not be shared with a 3rd party application for any reason.',
        icon: Icons.lock_person),
  ];
}

class LoginModel {
  String title;
  String body;
  IconData icon;
  LoginModel({required this.title, required this.body, required this.icon});
}
