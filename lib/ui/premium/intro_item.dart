import 'package:analysist/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/ui/premium/premium.dart';

class IntroItemView extends StatelessWidget {
  IntroItem introItem;
  IntroItemView({Key? key, required this.introItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: getVerticalSize(10),
          ),
          Text(
            translate(
              introItem.title,
            ),
            style: getBoldStyle(color: ColorManager.primary, fontSize: 18),
          ),
          SizedBox(
            height: getVerticalSize(10),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(30)),
            child: Text(
              translate(
                introItem.desc,
              ),
              textAlign: TextAlign.center,
              style: getRegularStyle(color: ColorManager.primary, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
