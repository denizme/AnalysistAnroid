import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/core/math_utils.dart';
import 'package:shimmer/shimmer.dart';

import 'detail.dart';

class EmptyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(180), color: Colors.white),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: Color.fromRGBO(158, 158, 158, 1),
                  ),
                  SizedBox(
                    width: getHorizontalSize(20),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
                      Container(
                        width: getHorizontalSize(200),
                        height: 10,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(3)),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
