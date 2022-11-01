import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/styles_manager.dart';

import 'colors.dart';
import 'math_utils.dart';

showInfoDialog(context, String title, String body, Function onTap) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
              opacity: a1.value, child: infoFullDialog(title, body, onTap)),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      });
}

Widget infoFullDialog(String title, String body, Function onTap) {
  return Dialog(
    backgroundColor: ColorManager.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: getHorizontalSize(5),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator(
                      value: 30,
                      strokeWidth: 2.5,
                      color: ColorManager.primary,
                    )),
                Icon(
                  Icons.info,
                  color: ColorManager.primary,
                  size: 40,
                )
              ],
            ),
            SizedBox(
              height: getHorizontalSize(5),
            ),
            SizedBox(
              height: getHorizontalSize(10),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: getBoldStyle(color: ColorManager.primary, fontSize: 16),
            ),
            SizedBox(
              height: getHorizontalSize(10),
            ),
            Text(
              body,
              textAlign: TextAlign.center,
              style: getRegularStyle(
                color: ColorManager.primary,
              ),
              // style:
              //     AppStyle.txtManropeMedium12Bluegray501.copyWith(fontSize: 12),
            ),
            SizedBox(
              height: getHorizontalSize(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          onPrimary: ColorManager.primary,
                          primary: Colors.white,
                          textStyle: getBoldStyle(color: Colors.white),
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          shape: StadiumBorder()),
                      child: Text(
                        translate("Cancel"),
                        style: getBoldStyle(
                          fontSize: 13,
                          color: ColorManager.primary,
                        ),
                      )),
                ),
                Container(
                  width: 80,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        onTap();
                      },
                      style: ElevatedButton.styleFrom(
                          onPrimary: ColorManager.primary,
                          primary: Colors.white,
                          textStyle: getBoldStyle(color: Colors.white),
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          shape: StadiumBorder()),
                      child: Text(
                        translate("Okey"),
                        style: getBoldStyle(
                          fontSize: 13,
                          color: ColorManager.primary,
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
