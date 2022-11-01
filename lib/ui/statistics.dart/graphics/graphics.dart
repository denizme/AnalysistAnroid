import 'package:analysist/core/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/boxes.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/models/Followers.dart';
import 'package:analysist/ui/statistics.dart/graphics/new_follower_graph.dart';
import 'package:analysist/ui/statistics.dart/graphics/new_followings_graph.dart';
import 'package:analysist/widgets/premium_glass.dart';

import '../../landing/user_controller.dart';

class Graphics extends StatelessWidget {
  const Graphics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<UserController>();

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
            translate(
              "Graphics",
            ),
            style: getMediumStyle(color: ColorManager.primary, fontSize: 17),
          ),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: ColorManager.backgroundColor,
          ),
          child: Stack(
            children: [
              IgnorePointer(
                ignoring: !Get.find<UserController>().purchased,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: NewFollowersGraph(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: NewFollowingsGraph(),
                    ),
                  ],
                ),
              ),
              PremiumGlass()
            ],
          ),
        ),
      ),
    );
  }
}
