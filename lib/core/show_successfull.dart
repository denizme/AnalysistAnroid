import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/styles_manager.dart';

import 'colors.dart';
import 'math_utils.dart';

showSuccessfulDialog(context, String title, String body) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child:
              Opacity(opacity: a1.value, child: successFullDialog(title, body)),
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

Widget successFullDialog(
  String title,
  String body,
) {
  return Dialog(
    backgroundColor: ColorManager.primary,
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
                    color: Colors.white,
                  )),
              Icon(
                Icons.check,
                color: Colors.white,
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
            style: getBoldStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(
            height: getHorizontalSize(10),
          ),
          Text(
            body,
            textAlign: TextAlign.center,
            style: getRegularStyle(color: Colors.white),
            // style:
            //     AppStyle.txtManropeMedium12Bluegray501.copyWith(fontSize: 12),
          ),
          SizedBox(
            height: getHorizontalSize(10),
          ),
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                  onPrimary: ColorManager.primary,
                  primary: Colors.white,
                  textStyle: getBoldStyle(color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shape: StadiumBorder()),
              child: Text(
                'Tamam',
                style: getBoldStyle(
                  fontSize: 13,
                  color: ColorManager.primary,
                ),
              ))
        ],
      ),
    ),
  );
}
