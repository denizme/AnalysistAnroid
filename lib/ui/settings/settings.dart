import 'package:analysist/core/show_toast.dart';
import 'package:analysist/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:in_app_review/in_app_review.dart';
import 'package:analysist/core/boxes.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/premium/premium.dart';
import 'package:mailto/mailto.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/show_info_dialog.dart';
import '../../core/styles_manager.dart';
import '../../models/Account.dart';
import '../../services/remote_config.dart';
import '../../widgets/premium_glass.dart';
import '../login/welcome.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget listTileWidget(
        Widget icon, String text, String subtitle, Function onTap) {
      return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: getVerticalSize(6)),
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5)),
                      child: icon),
                  SizedBox(
                    width: getHorizontalSize(10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translate(text),
                        style: getMediumStyle(
                            color: ColorManager.primary, fontSize: 14),
                      ),
                      SizedBox(
                        height: getVerticalSize(3),
                      ),
                      Text(
                        translate(subtitle),
                        style: getRegularStyle(
                            color: Colors.grey.shade500, fontSize: 12),
                      ),
                    ],
                  )
                ],
              )),
        ),
      );
    }

    Widget notiWidget(
        Widget icon, String text, String subtitle, Function onTap) {
      return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: getVerticalSize(6)),
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.all(11),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)),
                    child: icon),
                SizedBox(
                  width: getHorizontalSize(10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translate(text),
                      style: getMediumStyle(
                          color: ColorManager.primary, fontSize: 14),
                    ),
                    SizedBox(
                      height: getVerticalSize(3),
                    ),
                    Text(
                      translate(subtitle),
                      style: getRegularStyle(
                          color: Colors.grey.shade500, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Switch(
                  onChanged: (bool value) {},
                  value: true,
                  activeColor: ColorManager.primary,
                )
              ],
            ),
          ),
        ),
      );
    }

    return GetBuilder<UserController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:
                        MediaQuery.of(context).padding.top + getVerticalSize(8),
                  ),
                  Row(
                    children: [
                      controller.user == null
                          ? Center(
                              child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: CircleAvatar(
                                radius: 28,
                              ),
                            ))
                          : Center(
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                    controller.user!.user.profilePicUrl),
                              ),
                            ),
                      SizedBox(
                        width: getHorizontalSize(15),
                      ),
                      controller.user == null
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.user!.user.fullName,
                                  style: getRegularStyle(
                                      color: ColorManager.primary,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: getVerticalSize(5),
                                ),
                                Text(
                                  controller.user!.user.username,
                                  style: getRegularStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.showOverlay(
                              asyncFunction: () async {
                                await Get.find<UserController>()
                                    .refreshAccount();
                              },
                              loadingWidget: loading());
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade200),
                          child: Icon(
                            Icons.change_circle_rounded,
                            color: ColorManager.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(),

                  InkWell(
                    onTap: () {
                      Get.bottomSheet(Premium(),
                          elevation: 2,
                          enableDrag: true,
                          persistent: true,
                          isDismissible: true,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))));
                      Get.find<UserController>().changeTabOpen(false);
                      Get.find<UserController>().changeHideBanner(false);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.amberAccent.shade200),
                            child: CircleAvatar(
                              radius: 12,
                              child: Icon(Icons.star,
                                  size: 17, color: Colors.amberAccent.shade200),
                            ),
                          ),
                          SizedBox(
                            width: getHorizontalSize(10),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translate("Click for PREMIUM"),
                                style: getMediumStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              SizedBox(
                                height: getVerticalSize(4),
                              ),
                              Text(
                                translate("Unlock unlimited access."),
                                style: getRegularStyle(
                                    color: Colors.grey.shade600, fontSize: 13),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  Divider(),
                  SizedBox(
                    height: getVerticalSize(5),
                  ),

                  Text(
                    translate("Notification Settings"),
                    style: getMediumStyle(color: Colors.black, fontSize: 14),
                  ),

                  SizedBox(
                    height: getVerticalSize(5),
                  ),

                  notiWidget(
                      Icon(Icons.trending_up,
                          size: 20, color: ColorManager.primary),
                      "News Notifications",
                      'Notify on new movements.', () {
                    Share.share(appLink);
                  }),
                  Divider(),
                  SizedBox(
                    height: getVerticalSize(5),
                  ),
                  Text(
                    translate("Settings"),
                    style: getMediumStyle(color: Colors.black, fontSize: 14),
                  ),
                  SizedBox(
                    height: getVerticalSize(5),
                  ),
                  controller.accounts.length == 1
                      ? listTileWidget(
                          Icon(Icons.add,
                              size: 20, color: ColorManager.primary),
                          "New Account",
                          'You can add a new account', () {
                          bool purchased = Get.find<UserController>().purchased;

                          if (!purchased) {
                            Get.dialog(Material(
                                color: Colors.transparent,
                                child: PremiumGlass()));
                          } else {
                            Get.to(Welcome(), transition: Transition.downToUp);
                            Get.find<UserController>().changeTabOpen(false);
                            Get.find<UserController>().changeHideBanner(false);
                          }
                        })
                      : InkWell(
                          onTap: () {
                            Get.showOverlay(
                                asyncFunction: () async {
                                  await Get.find<UserController>()
                                      .changeAccount(controller.accounts
                                          .where((element) =>
                                              element.userId !=
                                              controller.user!.user.pk
                                                  .toString())
                                          .first);
                                },
                                loadingWidget: loading());
                          },
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: getVerticalSize(6)),
                              child: Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(11),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          controller.accounts
                                                  .where((element) =>
                                                      element.userId !=
                                                      controller.user!.user.pk
                                                          .toString())
                                                  .first
                                                  .photoUrl ??
                                              '',
                                          width: 20,
                                          height: 20,
                                        ),
                                      )),
                                  SizedBox(
                                    width: getHorizontalSize(10),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        translate(controller.accounts
                                                .where((element) =>
                                                    element.userId !=
                                                    controller.user!.user.pk
                                                        .toString())
                                                .first
                                                .username ??
                                            ''),
                                        style: getMediumStyle(
                                            color: ColorManager.primary,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 1.5)),
                                    child: Icon(
                                      Icons.change_circle,
                                      color: ColorManager.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  listTileWidget(
                      Icon(Icons.notifications_active,
                          size: 20, color: ColorManager.primary),
                      'Share App',
                      'Invite your friends to Analysist', () {
                    Share.share(appLink);
                  }),
                  listTileWidget(
                      Icon(Icons.price_check,
                          size: 20, color: ColorManager.primary),
                      'Restore Purchases',
                      'Reloads existing subscription', () async {
                    Get.showOverlay(
                        asyncFunction: () async {
                          PurchaserInfo purchaserInfo =
                              await Purchases.restoreTransactions();

                          if (purchaserInfo.activeSubscriptions.isEmpty) {
                            Get.find<UserController>().setPurchased(
                                purchaserInfo.activeSubscriptions.first);
                            showToast(
                                "${translate("Your subscription is active")}:${purchaserInfo.activeSubscriptions.first}");
                          } else {
                            showToast(
                                translate("You do not have any subscription"));
                          }
                        },
                        loadingWidget: loading());
                  }),

                  listTileWidget(
                      Icon(Icons.bug_report,
                          size: 20, color: ColorManager.primary),
                      'Report Problem',
                      'Help us make Analysist better.', () async {
                    final mailtoLink = Mailto(
                      to: [supportEmail],
                    );
                    // Convert the Mailto instance into a string.
                    // Use either Dart's string interpolation
                    // or the toString() method.
                    await launch('$mailtoLink');
                  }),
                  listTileWidget(
                      Icon(Icons.privacy_tip,
                          size: 20, color: ColorManager.primary),
                      'Privacy Policy',
                      'We never share or store your information', () {
                    String privacyPolicy = RemoteConfigService().privacyPolicy;
                    launchUrl(Uri.parse(privacyPolicy));
                  }),
                  listTileWidget(
                      Icon(Icons.emoji_emotions,
                          size: 20, color: ColorManager.primary),
                      'Rate Us',
                      'We love you too', () async {
                    try {
                      final InAppReview inAppReview = InAppReview.instance;

                      if (await inAppReview.isAvailable()) {
                        await inAppReview.requestReview();
                        inAppReview.openStoreListing();
                      } else {
                        launchUrl(Uri.parse(appLink));
                      }
                    } catch (e) {
                      launchUrl(Uri.parse(appLink));
                    }
                  }),
                  listTileWidget(
                      Icon(Icons.code, size: 20, color: ColorManager.primary),
                      '1.0.2',
                      'Current App Version',
                      () {}),

                  listTileWidget(
                      Icon(Icons.logout, size: 20, color: ColorManager.primary),
                      "Log Out",
                      "You won't lose your existing reports", () {
                    showInfoDialog(context, translate("Log Out"),
                        translate('Are you sure want to log out?'), () {
                      var accountBox = Boxes.getAccounts();
                      Account? account =
                          Get.find<UserController>().choosenAccount;
                      accountBox.delete(account!.userId);
                      if (accountBox.values.toList().isNotEmpty) {
                        Get.showOverlay(asyncFunction: () async {
                          await Get.find<UserController>()
                              .changeAccount(accountBox.values.toList()[0]);
                        });
                      } else {
                        Get.to(Welcome(), transition: Transition.downToUp);
                        Get.find<UserController>().changeTabOpen(false);
                        Get.find<UserController>().changeHideBanner(false);
                      }
                    });
                  }),
                  // listTileWidget(
                  //     Image.asset("assets/images/premium.png",
                  //         width: 20, height: 20, color: ColorManager.primary),
                  //     'Go Premium',
                  //     'Go Premium', () {
                  //   Get.to(() => Premium());
                  // }),
                  // listTileWidget(
                  //     Icon(Icons.notifications_active,
                  //         size: 20, color: ColorManager.primary),
                  //     'Notifications',
                  //     'Go Premium', () {
                  //   Get.to(() => NotificationsView());
                  // }),

                  // Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: getHorizontalSize(30)),
                  //   child: Container(
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(8)),
                  //       child: Column(
                  //         children: [
                  //           Column(
                  //             children: Boxes.getAccounts()
                  //                 .values
                  //                 .toList()
                  //                 .map((account) {
                  //               return InkWell(
                  //                 onTap: () {
                  //                   Get.find<UserController>()
                  //                       .changeAccount(account);
                  //                 },
                  //                 child: Container(
                  //                   margin: EdgeInsets.symmetric(vertical: 0),
                  //                   padding: EdgeInsets.symmetric(
                  //                       horizontal: getHorizontalSize(25)),
                  //                   child: Padding(
                  //                     padding: EdgeInsets.all(0),
                  //                     child: ListTile(
                  //                       contentPadding: EdgeInsets.symmetric(
                  //                           horizontal: 15, vertical: 0),
                  //                       shape: RoundedRectangleBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(5)),
                  //                       tileColor: Colors.white10,
                  //                       leading: account.photoUrl == null
                  //                           ? null
                  //                           : Container(
                  //                               width: 30,
                  //                               margin:
                  //                                   EdgeInsets.only(left: 0),
                  //                               padding: EdgeInsets.all(2),
                  //                               decoration: BoxDecoration(
                  //                                 color: Colors.white,
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(5),
                  //                               ),
                  //                               child: ClipRRect(
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(5),
                  //                                 child: Image.network(
                  //                                     account.photoUrl!),
                  //                               ),
                  //                             ),
                  //                       title: account.username == null
                  //                           ? null
                  //                           : Text(
                  //                               account.username!,
                  //                               style: getMediumStyle(
                  //                                   color: Colors.black,
                  //                                   fontSize: 16),
                  //                             ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               );
                  //             }).toList(),
                  //           ),
                  //           InkWell(
                  //             onTap: () {
                  //               bool purchased =
                  //                   Get.find<UserController>().purchased;

                  //               if (!purchased) {
                  //                 Get.dialog(Material(
                  //                     color: Colors.transparent,
                  //                     child: PremiumGlass()));
                  //               } else {
                  //                 Get.to(Welcome(),
                  //                     transition: Transition.downToUp);
                  //               }
                  //             },
                  //             child: Container(
                  //               margin: EdgeInsets.symmetric(vertical: 0),
                  //               padding: EdgeInsets.symmetric(
                  //                   horizontal: getHorizontalSize(25)),
                  //               child: Padding(
                  //                 padding: EdgeInsets.all(0),
                  //                 child: ListTile(
                  //                   contentPadding: EdgeInsets.symmetric(
                  //                       horizontal: 15, vertical: 0),
                  //                   shape: RoundedRectangleBorder(
                  //                       borderRadius: BorderRadius.circular(5)),
                  //                   tileColor: Colors.white10,
                  //                   leading: Icon(
                  //                     IconlyBold.plus,
                  //                     size: 30,
                  //                     color: ColorManager.primary,
                  //                   ),
                  //                   title: Text(
                  //                     translate("New Account"),
                  //                     style: getMediumStyle(
                  //                         color: ColorManager.primary,
                  //                         fontSize: 16),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       )),
                  // ),
                ],
              )),
        );
      },
    );
  }
}
