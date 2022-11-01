import 'package:analysist/models/Followers.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/show_successfull.dart';
import 'package:analysist/ui/premium/intro_item.dart';
import 'package:analysist/ui/premium/premium_controller.dart';
import 'package:analysist/ui/premium/sub_item.dart';
import 'package:analysist/ui/stories/stories_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/colors.dart';
import '../../core/math_utils.dart';
import '../../core/styles_manager.dart';
import '../../models/Followings.dart';
import '../../services/remote_config.dart';

class Premium extends StatelessWidget {
  const Premium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IntroItem> introItems = [
      IntroItem(
          title: "Analyze your Profile",
          desc:
              "Take control of your profile and don't miss out on unfollowers",
          path: '1'),
      IntroItem(
          title: "View Messages & Stories Secretly",
          desc: "Sneak through messages and stories and don't get caught",
          path: '2'),
      IntroItem(
          title: "Download Medias",
          desc: "Posts, stories and profile photos... Download everything",
          path: '3'),
      IntroItem(title: "Remove Ads", desc: "Enjoy the ad-free use", path: '4'),
      IntroItem(
          title: "Get Notifications",
          desc: "Get notifications story views unfollows and more of them",
          path: '5'),
    ];
    return WillPopScope(
      onWillPop: () {
        Get.find<UserController>().changeTabOpen(true);
        Get.find<UserController>().changeHideBanner(true);
        return Future.value(true);
      },
      child: Container(
        height: getVerticalSize(600),
        child: Card(
          color: Colors.white,
          elevation: 5,
          shadowColor: Colors.grey,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: GetBuilder<PremiumController>(
              init: PremiumController(),
              builder: (controller) {
                List<FollowingUsers> followings =
                    Get.find<UserController>().followings;
                List<FollowerUsers> followers =
                    Get.find<UserController>().followers;
                return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 7,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade300),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Pro Üyelik',
                          style: getMediumStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        followings.isEmpty || followers.isEmpty
                            ? Container()
                            : Container(
                                height: getVerticalSize(50),
                                width: double.infinity,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    controller: controller.scrollController,
                                    itemCount: followings.length > 10
                                        ? followings.length
                                        : followers.length,
                                    itemBuilder: (context, index) {
                                      if (followings.length > 10) {
                                        FollowingUsers following =
                                            followings[index];

                                        return Container(
                                          height: getVerticalSize(50),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(following
                                                      .profilePicUrl!))),
                                        );
                                      } else {
                                        FollowerUsers follower =
                                            followers[index];
                                        return Container(
                                          height: getVerticalSize(60),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(follower
                                                      .profilePicUrl!))),
                                        );
                                      }
                                    }),
                              ),
                        CarouselSlider(
                            items: introItems.map<Widget>((e) {
                              return Container(
                                  child: IntroItemView(introItem: e));
                            }).toList(),
                            options: CarouselOptions(
                              height: getVerticalSize(90),
                              viewportFraction: 1,
                              initialPage: 0,
                              enlargeStrategy: CenterPageEnlargeStrategy.scale,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 1400),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false,
                              onPageChanged: (int page, c) {
                                controller.changePage(page);
                              },
                              scrollDirection: Axis.horizontal,
                            )),
                        AnimatedSmoothIndicator(
                          activeIndex: controller.currentPage,
                          count: introItems.length,
                          effect: WormEffect(
                              spacing: 8.0,
                              radius: 100.0,
                              dotWidth: 10.0,
                              dotHeight: 10.0,
                              paintStyle: PaintingStyle.fill,
                              strokeWidth: 0.5,
                              dotColor: Colors.grey.shade300,
                              activeDotColor: ColorManager.primary),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                              children: controller.packages
                                  .map((e) => SubItem(
                                        package: e,
                                        choosenPackage:
                                            controller.choosenPackage,
                                      ))
                                  .toList()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xff4d83d7),
                                    Color(0xff973abf)
                                  ]),
                                  color: ColorManager.primary,
                                  borderRadius: BorderRadius.circular(8)),
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.purchase();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  child: Text(
                                    translate('Unlimited Access'),
                                    style: getBoldStyle(
                                        color: Colors.white, fontSize: 20),
                                  ))),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getHorizontalSize(15)),
                              child: Text(
                                translate("purchase_info_long"),
                                textAlign: TextAlign.center,
                                style: getRegularStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getHorizontalSize(15)),
                              child: InkWell(
                                onTap: () {
                                  String privacyPolicy =
                                      RemoteConfigService().privacyPolicy;
                                  launchUrl(Uri.parse(privacyPolicy));
                                },
                                child: Text(translate("Privacy Policy"),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey.shade700,
                                      fontSize: 10,
                                      decoration: TextDecoration.underline,
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        )
                      ],
                    ));
              }),
        ),
      ),
    );
  }
}

class IntroItem {
  String title;
  String desc;
  String path;
  IntroItem({required this.title, required this.desc, required this.path});
}
