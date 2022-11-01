import 'package:analysist/core/colors.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/styles_manager.dart';

class BestTimeForPosts extends StatelessWidget {
  List<BestTimeMedia> medias = [
    BestTimeMedia(title: "00:00-01:00", count: 0),
    BestTimeMedia(title: "01:00-02:00", count: 1),
    BestTimeMedia(title: "02:00-03:00", count: 2),
    BestTimeMedia(title: "03:00-04:00", count: 3),
    BestTimeMedia(title: "04:00-05:00", count: 4),
    BestTimeMedia(title: "05:00-06:00", count: 5),
    BestTimeMedia(title: "06:00-07:00", count: 6),
    BestTimeMedia(title: "07:00-08:00", count: 7),
    BestTimeMedia(title: "08:00-09:00", count: 8),
    BestTimeMedia(title: "09:00-10:00", count: 9),
    BestTimeMedia(title: "10:00-11:00", count: 10),
    BestTimeMedia(title: "11:00-12:00", count: 11),
    BestTimeMedia(title: "12:00-13:00", count: 12),
    BestTimeMedia(title: "13:00-14:00", count: 13),
    BestTimeMedia(title: "14:00-15:00", count: 14),
    BestTimeMedia(title: "15:00-16:00", count: 15),
    BestTimeMedia(title: "16:00-17:00", count: 16),
    BestTimeMedia(title: "17:00-18:00", count: 17),
    BestTimeMedia(title: "18:00-19:00", count: 18),
    BestTimeMedia(title: "19:00-20:00", count: 19),
    BestTimeMedia(title: "20:00-21:00", count: 20),
    BestTimeMedia(title: "21:00-22:00", count: 21),
    BestTimeMedia(title: "22:00-23:00", count: 22),
    BestTimeMedia(title: "23:00-24:00", count: 23),
  ];
  @override
  Widget build(BuildContext context) {
    medias.shuffle();
    return WillPopScope(
      onWillPop: () {
        Get.find<UserController>().changeTabOpen(true);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.secondary,
          elevation: 2,
          toolbarHeight: kToolbarHeight - 5,
          centerTitle: false,
          shadowColor: Colors.grey.shade200,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: ColorManager.primary,
              )),
          title: Text(translate("Best Time to Post"),
              style: getRegularStyle(
                fontSize: 17,
                color: ColorManager.primary,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
              children:
                  medias.map((e) => bodyWidget(e.title, e.count)).toList()),
        ),
      ),
    );
  }

  Widget bodyWidget(text, count) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: getBoldStyle(color: Colors.black, fontSize: 17),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                '${Get.find<UserController>().postMedias.where((element) => DateTime.fromMillisecondsSinceEpoch(Get.find<UserController>().postMedias[0]!.node!.takenAtTimestamp! * 1000).hour == count).length} ${translate("shared a post")}',
                style: getBoldStyle(color: Colors.grey.shade500, fontSize: 14),
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300, width: 1.5)),
            child: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}

class BestTimeMedia {
  String title;
  int count;
  BestTimeMedia({required this.title, required this.count});
}
