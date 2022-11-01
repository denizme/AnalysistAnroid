import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../services/remote_config.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt currentIndex = 1.obs;
  TabController? tabController;
  changeIndex(int newIndex) {
    currentIndex.value = newIndex;
  }

  int loginPage = 0;
  changeLoginPage(int newLoginPage) {
    loginPage = newLoginPage;
    update();
  }

  @override
  void onInit() {
    tabController = TabController(
        length: RemoteConfigService().messagesActive ? 5 : 4, vsync: this);
    tabController!.addListener(() {
      currentIndex.value = tabController!.index + 1;
    });
    super.onInit();
  }

  onChanged(value) {
    update();
  }
}
