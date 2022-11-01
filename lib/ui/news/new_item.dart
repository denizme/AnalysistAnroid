import 'package:flutter/material.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:analysist/core/styles_manager.dart';

import '../../models/News.dart';

class NewItem extends StatelessWidget {
  Story story;
  NewItem({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getVerticalSize(10)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(180)),
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: ColorManager.primary,
              backgroundImage: NetworkImage(story.args!.profileImage!),
            ),
            title: RichText(
              text: TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: story.args!.profileName.toString(),
                      style: getBoldStyle(color: Colors.black)),
                  TextSpan(
                      text: story.args!.text!
                          .toString()
                          .replaceAll("${story.args!.profileName}", "")
                          .toString(),
                      style: getRegularStyle(color: Colors.black)),
                ],
              ),
            )),
      ),
    );
  }
}
