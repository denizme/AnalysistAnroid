import 'package:analysist/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/models/Followers.dart';
import 'package:analysist/models/Followings.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/users/followings/following_info_dialog.dart';
import 'package:analysist/ui/users/userInfoDialog.dart';

import '../../../services/info.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/photo_detail.dart';

class FollowingCard extends StatelessWidget {
  FollowingUsers user;
  FollowingCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return ListTile(
        minVerticalPadding: 0,
        onTap: () {
          Get.generalDialog(
            barrierDismissible: true,
            barrierLabel: "",
            pageBuilder: (_, __, ___) {
              return FollowingInfoDialog(
                user: user,
              );
            },
            transitionBuilder: (_, anim, __, child) {
              Tween<Offset> tween;
              if (anim.status == AnimationStatus.reverse) {
                tween = Tween(begin: Offset(0, 1), end: Offset.zero);
              } else {
                tween = Tween(begin: Offset(0, 1), end: Offset.zero);
              }

              return SlideTransition(
                position: tween.animate(anim),
                child: FadeTransition(
                  opacity: anim,
                  child: child,
                ),
              );
            },
          );
        },
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        leading: InkWell(
          onTap: () async {
            Get.showOverlay(
                asyncFunction: () async {
                  String? cookie =
                      Get.find<UserController>().choosenAccount!.cookie;
                  await info(user.pk.toString(), cookie).then((value) {
                    if (value != null) {
                      value.user.hdProfilePicVersions!
                          .sort((a, b) => b.width.compareTo(a.width));

                      String photo = value.user.hdProfilePicVersions![0].url;
                      Get.to(PhotoDetail(
                        photo: photo,
                      ));
                    }
                  });
                },
                loadingWidget: loading());
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: NetworkImage(user.profilePicUrl!),
          ),
        ),
        title: Text(
          user.fullName.toString(),
          style: getBoldStyle(color: ColorManager.primary, fontSize: 15),
        ),
        subtitle: Text(
          user.username.toString(),
          style: getMediumStyle(color: ColorManager.primary, fontSize: 12),
        ),
        trailing: controller.followingIds.contains(user.pk)
            ? Container(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onPrimary: Colors.blueAccent,
                      shadowColor: Colors.transparent,
                      textStyle: getMediumStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(horizontal: 10)),
                  onPressed: () {},
                  child: Text(translate('Follow')),
                ),
              )
            : Container(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: getMediumStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(horizontal: 10)),
                  onPressed: () {},
                  child: Text(translate('UnFollow')),
                ),
              ),
      );
    });
  }
}
