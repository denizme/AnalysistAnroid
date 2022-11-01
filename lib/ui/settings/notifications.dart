import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/ui/landing/user_controller.dart';

import '../../core/styles_manager.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: AppBar(
        title: Text(translate("Notifications")),
        elevation: 0,
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [ColorManager.primary, ColorManager.secondary])),
          padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(25)),
          child: GetBuilder<UserController>(builder: (controller) {
            return Column(
              children: [
                SizedBox(
                  height: getVerticalSize(20),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(180),
                          color: Colors.white),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 0),
                        padding: EdgeInsets.symmetric(
                            horizontal: getHorizontalSize(25)),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: getHorizontalSize(8), vertical: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            tileColor: Colors.white10,
                            title: Text(
                              translate("News"),
                              style: getMediumStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            trailing: Switch(
                              onChanged: (bool value) {
                                controller.changeProfileVisits(value);
                              },
                              value: controller.profileVisitNoti,
                              activeColor: ColorManager.primary,
                              inactiveThumbColor: Colors.grey,
                            ),
                          ),
                        ),
                      )),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   child: Container(
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(180),
                //           color: Colors.white),
                //       child: Container(
                //         margin: EdgeInsets.symmetric(vertical: 0),
                //         padding: EdgeInsets.symmetric(
                //             horizontal: getHorizontalSize(25)),
                //         child: Padding(
                //           padding: EdgeInsets.all(0),
                //           child: ListTile(
                //             contentPadding: EdgeInsets.symmetric(
                //                 horizontal: getHorizontalSize(8), vertical: 0),
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(5)),
                //             tileColor: Colors.white10,
                //             title: Text(
                //               translate("New Followers"),
                //               style: getMediumStyle(
                //                   color: Colors.black, fontSize: 16),
                //             ),
                //             trailing: Switch(
                //               onChanged: (bool value) {
                //                 controller.changenewFollowerNoti(value);
                //               },
                //               value: controller.newFollowerNoti,
                //               activeColor: ColorManager.primary,
                //               inactiveThumbColor: Colors.grey,
                //             ),
                //           ),
                //         ),
                //       )),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   child: Container(
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(180),
                //           color: Colors.white),
                //       child: Container(
                //         margin: EdgeInsets.symmetric(vertical: 0),
                //         padding: EdgeInsets.symmetric(
                //             horizontal: getHorizontalSize(25)),
                //         child: Padding(
                //           padding: EdgeInsets.all(0),
                //           child: ListTile(
                //             contentPadding: EdgeInsets.symmetric(
                //                 horizontal: getHorizontalSize(8), vertical: 0),
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(5)),
                //             tileColor: Colors.white10,
                //             title: Text(
                //               translate("Who Blocked Me"),
                //               style: getMediumStyle(
                //                   color: Colors.black, fontSize: 16),
                //             ),
                //             trailing: Switch(
                //               onChanged: (bool value) {
                //                 controller.changewhoBlockedMeNoti(value);
                //               },
                //               value: controller.whoBlockedMeNoti,
                //               activeColor: ColorManager.primary,
                //               inactiveThumbColor: Colors.grey,
                //             ),
                //           ),
                //         ),
                //       )),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   child: Container(
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(180),
                //           color: Colors.white),
                //       child: Container(
                //         margin: EdgeInsets.symmetric(vertical: 0),
                //         padding: EdgeInsets.symmetric(
                //             horizontal: getHorizontalSize(25)),
                //         child: Padding(
                //           padding: EdgeInsets.all(0),
                //           child: ListTile(
                //             contentPadding: EdgeInsets.symmetric(
                //                 horizontal: getHorizontalSize(8), vertical: 0),
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(5)),
                //             tileColor: Colors.white10,
                //             title: Text(
                //               translate("Story Views"),
                //               style: getMediumStyle(
                //                   color: Colors.black, fontSize: 16),
                //             ),
                //             trailing: Switch(
                //               onChanged: (bool value) {
                //                 controller.changestoryViewNoti(value);
                //               },
                //               value: controller.storyViewNoti,
                //               activeColor: ColorManager.primary,
                //               inactiveThumbColor: Colors.grey,
                //             ),
                //           ),
                //         ),
                //       )),
                // ),
              ],
            );
          })),
    );
  }
}
