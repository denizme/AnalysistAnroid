import 'package:analysist/widgets/lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/models/Followings.dart';
import 'package:analysist/ui/home/home_controller.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/users/user_card.dart';
import '../../../core/constants.dart';
import '../../../models/Followers.dart';
import '../../../widgets/premium_glass.dart';
import 'following_card.dart';

class FollowingsView extends StatelessWidget {
  String title;

  List<FollowingUsers> followings;
  FollowingsView({Key? key, required this.title, required this.followings});

  List<FollowingUsers> searchFollowings = [];

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
            backgroundColor: ColorManager.backgroundColor,
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
            )),
        body: Container(
          decoration: BoxDecoration(
            color: ColorManager.backgroundColor,
          ),
          child: GetBuilder<HomeController>(builder: (controller) {
            if (textEditingController.text.isNotEmpty) {
              searchFollowings.clear();
              for (var user in followings) {
                if (user.fullName!
                        .toLowerCase()
                        .contains(textEditingController.text.toLowerCase()) ||
                    user.username!
                        .toLowerCase()
                        .contains(textEditingController.text.toLowerCase())) {
                  searchFollowings.add(user);
                }
              }
            } else {
              searchFollowings.clear();
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
                          hintText: "Kullanıcı Ara...",
                          fillColor: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        IgnorePointer(
                          ignoring: !Get.find<UserController>().purchased,
                          child: followings.isEmpty
                              ? Center(
                                  child: LottiePage(
                                      width: double.infinity,
                                      heigth: double.infinity,
                                      lottie: 'no-data'),
                                )
                              : ListView.builder(
                                  itemCount: searchFollowings.isEmpty
                                      ? followings == null
                                          ? 0
                                          : followings.length
                                      : searchFollowings.length,
                                  itemBuilder: (context, index) {
                                    if (searchFollowings.isEmpty) {
                                      FollowingUsers followerUser =
                                          followings[index];

                                      return FollowingCard(user: followerUser);
                                    } else {
                                      FollowingUsers followerUser =
                                          searchFollowings[index];
                                      return FollowingCard(user: followerUser);
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
