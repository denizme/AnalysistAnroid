import 'package:flutter/material.dart';
import 'package:analysist/core/colors.dart';

import '../../core/constants.dart';
import '../../core/styles_manager.dart';

class Whycantlogin extends StatelessWidget {
  const Whycantlogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      insetPadding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ColorManager.primary, ColorManager.secondary])),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info,
              color: Colors.white,
              size: 65,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              translate(
                "Why_cant_login",
              ),
              textAlign: TextAlign.center,
              style: getBoldStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Divider(
                color: Colors.white,
                thickness: 0.1,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                translate(
                  "cannot_login_body",
                ),
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: Colors.white, fontSize: 12, height: 1.25),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
