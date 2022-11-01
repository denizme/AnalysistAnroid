import 'dart:ffi';

import 'package:analysist/models/Followers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../core/constants.dart';
import '../../core/show_error_dialog.dart';
import '../../core/show_successfull.dart';
import '../../models/Followings.dart';

class PremiumController extends GetxController {
  late ScrollController scrollController;
  Future<Offering?> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      Offering? current = offerings.current;

      return current;
    } on PlatformException catch (e) {
      logger.e(e);
      return null;
    }
  }

  List<Package> packages = [];
  getProducts() async {
    Offering? offering = await fetchOffers();
    if (offering != null) {
      packages.add(offering.monthly!);
      packages.add(offering.annual!);
      packages.add(offering.weekly!);
      choosenPackage = offering.annual;
      update();
    }
  }

  choosePackage(Package newPackage) {
    choosenPackage = newPackage;
    update();
  }

  int currentPage = 0;
  changePage(int newPage) {
    currentPage = newPage;
    update();
  }

  Package? choosenPackage;
  bool loaded = true;
  @override
  void onInit() {
    scrollController = ScrollController();
    initSc();
    update();
    getProducts();
    super.onInit();
  }

  initSc() async {
    await Future.delayed(Duration(milliseconds: 300)).then((value) {
      if (scrollController.hasClients) {
        double minScrollExtent1 = scrollController.position.minScrollExtent;
        double maxScrollExtent1 = scrollController.position.maxScrollExtent;
        List<FollowingUsers> followings = Get.find<UserController>().followings;
        List<FollowerUsers> followers = Get.find<UserController>().followers;
        if (followings.length < 10) {
          if (followers.length < 10) {
          } else {
            animateToMaxMin(
              maxScrollExtent1,
              minScrollExtent1,
              maxScrollExtent1,
              300,
            );
          }
        } else {
          animateToMaxMin(
            maxScrollExtent1,
            minScrollExtent1,
            maxScrollExtent1,
            300,
          );
        }
      } else {
        initSc();
      }
    });
  }

  animateToMaxMin(
    double max,
    double min,
    double direction,
    int seconds,
  ) {
    try {
      if (scrollController.hasClients) {
        scrollController
            .animateTo(direction,
                duration: Duration(seconds: seconds), curve: Curves.linear)
            .then((value) {
          direction = direction == max ? min : max;
          animateToMaxMin(
            max,
            min,
            direction,
            seconds,
          );
        });
      }
    } catch (e) {}
  }

  Future purchase() async {
    if (choosenPackage != null) {
      try {
        PurchaserInfo purchaserInfo =
            await Purchases.purchasePackage(choosenPackage!);
        Get.back();
        showSuccessfulDialog(
            Get.context,
            translate("Purchase Successfull"),
            translate(
                "You can start using premium features. We are happy to see you among us!😍"));

        Get.find<UserController>().changeTabOpen(true);
        Get.find<UserController>().changeHideBanner(true);

        if (choosenPackage!.packageType == PackageType.weekly) {
          Get.find<UserController>().setPurchased("monthly");
        } else {
          Get.find<UserController>().setPurchased("yearlys");
        }
      } on PlatformException catch (exception) {
        showErrorDialog(
            Get.context, translate("Error"), exception.message.toString());
      }
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    scrollController.dispose();
    super.onClose();
  }
}
