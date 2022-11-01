import 'package:analysist/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/search/SearchUser.dart';
import 'package:analysist/ui/search/search_user_info_dialog.dart';

import '../../core/constants.dart';
import '../../core/show_toast.dart';
import '../../services/follow.dart';
import '../../services/get_post_user.dart';
import '../../widgets/loading_widget.dart';

class SearchUserCard extends StatelessWidget {
  SearchUser user;
  SearchUserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        onTap: () {
          Get.generalDialog(
            barrierDismissible: true,
            barrierLabel: '',
            pageBuilder: (_, __, ___) {
              return SearchUserInfoDialog(
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
        leading: user.user.profilePicUrl == null
            ? null
            : CircleAvatar(
                radius: 23,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: NetworkImage(user.user.profilePicUrl!),
              ),
        title: user.user.fullName == null
            ? null
            : Text(
                user.user.fullName.toString(),
                style:
                    getMediumStyle(color: ColorManager.primary, fontSize: 15),
              ),
        subtitle: Text(
          user.user.username.toString(),
          style: getRegularStyle(color: ColorManager.primary, fontSize: 12),
        ),
        trailing: controller.followingIds.contains(user.user.pk)
            ? Container(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: getMediumStyle(color: Colors.white),
                      primary: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(horizontal: 10)),
                  onPressed: () {},
                  child: Text(translate("UnFollow")),
                ),
              )
            : Container(
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
                  onPressed: () {
                    Get.showOverlay(
                        asyncFunction: () async {
                          String? cookie = controller.choosenAccount!.cookie;
                          String? csrfToken =
                              controller.choosenAccount!.csrfToken;
                          await follow(
                                  user.user.pk.toString(), cookie, csrfToken)
                              .then((value) async {
                            if (value) {
                              await postUser(user.user.username!, cookie)
                                  .then((postUser) {
                                if (postUser!.data.user.followedByViewer ==
                                    true) {
                                  showToast(
                                    "You started following",
                                  );
                                  controller.addFollowingPostUser(postUser);
                                } else {
                                  showToast(
                                    "Follow request sent",
                                  );
                                }
                              });
                            } else {
                              showToast(
                                "Request Failed",
                              );
                            }
                          });
                        },
                        loadingWidget: loading());
                  },
                  child: Text(translate('Follow')),
                ),
              ),
      );
    });
  }
}
