import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:analysist/core/colors.dart';
import 'package:analysist/ui/home/bottom_tabbar.dart';
import 'package:analysist/ui/home/home_controller.dart';
import 'package:analysist/ui/search/search.dart';

import '../../services/remote_config.dart';
import '../messages/messages.dart';
import '../profile/profile.dart';
import '../settings/settings.dart';
import '../statistics.dart/statistics.dart';
import '../stories/stories.dart';

class Home extends GetWidget<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: RemoteConfigService().messagesActive ? 5 : 4,
      child: Scaffold(
        backgroundColor: ColorManager.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: TabBarView(
            controller: controller.tabController,
            children: RemoteConfigService().messagesActive
                ? [
                    Profile(),
                    Statistics(),
                    Search(),
                    MessagesView(),
                    SettingsView()
                  ]
                : [Profile(), Statistics(), Search(), SettingsView()]),
      ),
    );
  }
}
