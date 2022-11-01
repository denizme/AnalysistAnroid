import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:analysist/models/Account.dart';
import 'package:analysist/ui/home/home.dart';
import 'package:analysist/ui/home/home_controller.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:analysist/ui/login/welcome.dart';
import '../../core/boxes.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Account>>(
        valueListenable: Boxes.getAccounts().listenable(),
        builder: (content, box, _) {
          List<Account> accounts = box.values.toList();
          if (accounts.isEmpty) {
            Future.delayed(Duration(milliseconds: 250)).then((value) {
              Get.find<UserController>().changeTabOpen(false);
              Get.find<UserController>().changeHideBanner(false);
            });

            return Welcome();
          } else {
            Get.put(HomeController());
            return Home();
          }
        });
  }
}
