import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/models/Followings.dart';
import 'package:analysist/ui/home/home_controller.dart';
import 'package:analysist/ui/users/user_card.dart';

import '../../models/Followers.dart';

class Users extends StatelessWidget {
  String title;
  Users({Key? key, required this.title}) : super(key: key);

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<FollowerUsers>? users;
    if (Get.arguments is List<FollowerUsers>) {
      users = Get.arguments;
    } else if (Get.arguments is List<FollowingUsers>) {}

    List<FollowerUsers>? searchUsers = [];
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: AppBar(
          backgroundColor: ColorManager.backgroundColor,
          elevation: 0,
          title: Text(
            title,
            style: getBoldStyle(color: Colors.white, fontSize: 15),
          )),
      body: GetBuilder<HomeController>(builder: (controller) {
        if (textEditingController.text.isNotEmpty) {
          searchUsers.clear();
          for (var user in users!) {
            if (user.fullName!
                    .toLowerCase()
                    .contains(textEditingController.text.toLowerCase()) ||
                user.username!
                    .toLowerCase()
                    .contains(textEditingController.text.toLowerCase())) {
              searchUsers.add(user);
            }
          }
        } else {
          searchUsers.clear();
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
                  style: getRegularStyle(color: Colors.white, fontSize: 13),
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
                      fillColor: ColorManager.bottomBarColor),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: searchUsers.isEmpty
                        ? users == null
                            ? 0
                            : users.length
                        : searchUsers.length,
                    itemBuilder: (context, index) {
                      if (searchUsers.isEmpty) {
                        FollowerUsers followerUser = users![index];

                        return UserCard(user: followerUser);
                      } else {
                        FollowerUsers followerUser = searchUsers[index];
                        return UserCard(user: followerUser);
                      }
                    }),
              )
            ],
          ),
        );
      }),
    );
  }

  InputBorder getBorder() {
    return OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.bottomBarColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(5));
  }
}
