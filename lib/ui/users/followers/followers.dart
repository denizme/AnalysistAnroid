import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/ui/home/home_controller.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/premium/premium.dart';
import 'package:analysist/ui/users/followers/follower_card.dart';
import 'package:analysist/ui/users/user_card.dart';
import '../../../models/Followers.dart';
import '../../../widgets/lottie.dart';
import '../../../widgets/premium_glass.dart';

class FollowersView extends StatelessWidget {
  String title;
  List<FollowerUsers> followers;

  FollowersView({
    Key? key,
    required this.title,
    required this.followers,
  }) : super(key: key);
  List<FollowerUsers> searchFollowers = [];

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.find<UserController>().changeTabOpen(true);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: ColorManager.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: ColorManager.primary,
            ),
            onPressed: () {
              Get.find<UserController>().changeTabOpen(true);
              Navigator.pop(context);
            },
          ),
          centerTitle: false,
          title: Text(
            translate(title),
            style: getMediumStyle(color: ColorManager.primary, fontSize: 17),
          ),
          backgroundColor: ColorManager.backgroundColor,
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: ColorManager.backgroundColor,
          ),
          child: GetBuilder<HomeController>(builder: (controller) {
            if (textEditingController.text.isNotEmpty) {
              searchFollowers.clear();
              for (var user in followers) {
                if (user.fullName!
                        .toLowerCase()
                        .contains(textEditingController.text.toLowerCase()) ||
                    user.username!
                        .toLowerCase()
                        .contains(textEditingController.text.toLowerCase())) {
                  searchFollowers.add(user);
                }
              }
            } else {
              searchFollowers.clear();
            }
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    child: TextField(
                      controller: textEditingController,
                      onChanged: controller.onChanged,
                      style: getRegularStyle(color: Colors.black, fontSize: 13),
                      decoration: InputDecoration(
                          border: getBorder(),
                          enabledBorder: getBorder(),
                          focusedBorder: getBorder(),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintStyle:
                              getRegularStyle(color: Colors.grey, fontSize: 13),
                          hintText: "${translate("Search User")}...",
                          fillColor: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        IgnorePointer(
                          ignoring: !Get.find<UserController>().purchased,
                          child: followers.isEmpty
                              ? Center(
                                  child: LottiePage(
                                      width: double.infinity,
                                      heigth: double.infinity,
                                      lottie: 'no-data'),
                                )
                              : ListView.builder(
                                  itemCount: searchFollowers.isEmpty
                                      ? followers == null
                                          ? 0
                                          : followers.length
                                      : searchFollowers.length,
                                  itemBuilder: (context, index) {
                                    if (searchFollowers.isEmpty) {
                                      FollowerUsers followerUser =
                                          followers[index];

                                      return FollowerCard(user: followerUser);
                                    } else {
                                      FollowerUsers followerUser =
                                          searchFollowers[index];
                                      return FollowerCard(user: followerUser);
                                    }
                                  }),
                        ),
                        PremiumGlass()
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  InputBorder getBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(5));
  }
}
