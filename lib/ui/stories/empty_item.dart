import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/models/Stories.dart';
import 'package:analysist/ui/stories/stories_controller.dart';
import 'package:analysist/ui/stories/story_view.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:shimmer/shimmer.dart';

class EmptyItem extends StatelessWidget {
  int index;
  int length;
  EmptyItem({
    Key? key,
    required this.index,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(
          left: index == 0 ? 5 : 0, right: index == length - 1 ? 0 : 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        child: OutlineGradientButton(
          padding: EdgeInsets.all(2.5),
          gradient: LinearGradient(colors: [Colors.pink, Colors.purple]),
          strokeWidth: 3,
          radius: Radius.circular(50),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
