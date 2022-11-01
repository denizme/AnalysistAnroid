import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:analysist/models/Account.dart';
import 'package:analysist/services/get_messages.dart';
import 'package:analysist/ui/landing/user_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/Messages.dart';

class MessagesController extends GetxController {
  @override
  void onInit() {
    getMessages();
    super.onInit();
  }

  int limit = 20;
  bool loaded = false;
  Messages? fetchedMessages;
  Future getMessages([int limit = 20]) async {
    Account? account = Get.find<UserController>().choosenAccount;
    await messages(account!.userId, account.cookie, limit).then((value) {
      if (value != null) {
        fetchedMessages = value;
      }
      loaded = true;

      update();
    });
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RefreshController refreshController2 =
      RefreshController(initialRefresh: false);
  void onRefresh() async {
    // monitor network fetch
    limit += 10;
    await getMessages(limit);
    // if failed,use refreshFailed()

    refreshController.refreshCompleted();
    refreshController2.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    limit += 10;
    await getMessages(limit);
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadComplete();
    refreshController2.loadComplete();
  }
}
