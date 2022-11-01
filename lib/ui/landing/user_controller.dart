import 'dart:async';
import 'package:analysist/services/remote_config.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:analysist/core/boxes.dart';
import 'package:analysist/core/constants.dart';
import 'package:analysist/core/notifications.dart';
import 'package:analysist/models/Account.dart';
import 'package:analysist/models/Followers.dart';
import 'package:analysist/models/Followings.dart';
import 'package:analysist/models/News.dart';
import 'package:analysist/models/PostUser.dart';
import 'package:analysist/models/User.dart';
import 'package:analysist/services/get_followings.dart';
import 'package:analysist/ui/login/login.dart';
import 'package:analysist/ui/search/SearchUser.dart';
import 'package:analysist/ui/stories/stories_controller.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';

import '../../core/show_toast.dart';
import '../../services/get_followers.dart';
import '../../services/get_news.dart';
import '../../services/get_posts.dart';
import '../../services/info.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    getPrefs();
    setupPurchase();
    getSettings();
    initializeAndroidAlarmManager();
    super.onInit();
  }

  Future changeAccount(Account newAccount) async {
    if (newAccount != choosenAccount) {
      choosenAccount = newAccount;

      await getPrefs();
      await getSettings();
      await Get.find<StoriesController>().getStories();
      await initializeAndroidAlarmManager();
      update();
    }
  }

  Future getSettings() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    profileVisitNoti = preferences.getBool(
          'profileVisitNoti',
        ) ??
        true;
    newFollowerNoti = preferences.getBool(
          'newFollowerNoti',
        ) ??
        true;
    whoBlockedMeNoti = preferences.getBool(
          'whoBlockedMeNoti',
        ) ??
        true;
    storyViewNoti = preferences.getBool(
          'storyViewNoti',
        ) ??
        true;
    update();
  }

  bool profileVisitNoti = true;
  bool newFollowerNoti = true;
  bool whoBlockedMeNoti = true;
  bool storyViewNoti = true;
  changeProfileVisits(bool newValue) async {
    profileVisitNoti = newValue;
    update();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('profileVisitNoti', profileVisitNoti);
  }

  changenewFollowerNoti(bool newValue) async {
    newFollowerNoti = newValue;
    update();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('newFollowerNoti', profileVisitNoti);
  }

  changewhoBlockedMeNoti(bool newValue) async {
    whoBlockedMeNoti = newValue;
    update();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('whoBlockedMeNoti', profileVisitNoti);
  }

  changestoryViewNoti(bool newValue) async {
    storyViewNoti = newValue;
    update();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('storyViewNoti', profileVisitNoti);
  }

  Future setupPurchase() async {
    try {
      String? deviceid = await PlatformDeviceId.getDeviceId;
      await Purchases.setup(revenucatAppId, appUserId: deviceid);
      PurchaserInfo info = await Purchases.getPurchaserInfo();
      if (info.activeSubscriptions.isNotEmpty) {
        for (var sub in info.activeSubscriptions) {
          subscriptionStatus = sub;
        }
        purchased = true;
        update();
      } else {
        subscriptionStatus = "";
        purchased = false;
        update();
      }
    } catch (e) {
      logger.i(e.toString());
    }
  }

  setPurchased(String newSubscriptionStatus) {
    subscriptionStatus = newSubscriptionStatus;
    purchased = true;
    update();
  }

  String subscriptionStatus = "";
  bool purchased = false;
  User? user;
  List<FollowingUsers> followings = [];
  News? fecthedNews;
  List<FollowerUsers> followers = [];
  List<String> firstFollowersIds = [];
  List<String> firstFollowingIds = [];
  List<String> followersIds = [];
  List<String> followingIds = [];
  List<Account> accounts = [];
  Account? choosenAccount;
  List<Edge?> postMedias = [];
  Edge? mostLikedPost;
  Edge? mostCommentPost;
  Future getPrefs() async {
    loadingFollowers = true;
    loadingFollowings = true;
    lostFollowers = true;
    lostFollowings = true;
    loadingBlocks = true;
    nextMaxidFollowers = '';
    nextMaxidFollowings = '';
    followingIds.clear();
    followers.clear();
    followings.clear();
    postMedias.clear();
    followersIds.clear();
    firstFollowersIds.clear();
    firstFollowingIds.clear();
    final accountsBox = Boxes.getAccounts();

    accounts = accountsBox.values.toList();
    if (accounts.isNotEmpty) {
      choosenAccount ??= accounts.first;
      update();
      await getDatas();
    }
  }

  Future getDatas() async {
    await getInfo();
    await getUserFollowers();
    await getUserFollowings();
    await getPosts();
    countBlocks();
  }

  Future setAccount(Account newAccount) async {
    choosenAccount = newAccount;
    update();
  }

  Future getPosts() async {
    await posts(choosenAccount!.userId, choosenAccount!.cookie)
        .then((value) async {
      if (value != null) {
        postPageInfo = value.pageInfo;
        postMedias.addAll(value.edges!);

        for (var edge in postMedias) {
          if (mostCommentPost == null) {
            mostCommentPost = edge;
          } else {
            int? commentCount = edge!.node!.edgeMediaToComment!.count;
            if (commentCount! >
                mostCommentPost!.node!.edgeMediaToComment!.count!) {
              mostCommentPost = edge;
            }
          }
          if (mostLikedPost == null) {
            mostLikedPost = edge;
          } else {
            int? likeCount = edge!.node!.edgeMediaPreviewLike!.count;
            if (likeCount! >
                mostLikedPost!.node!.edgeMediaPreviewLike!.count!) {
              mostLikedPost = edge;
            }
          }
        }
        // if (postPageInfo != null && postPageInfo!.endCursor!.isNotEmpty) {
        //   getPosts();
        // }
        update();
      }
      update();
    });
  }

  PageInfo? postPageInfo;
  Future getNews() async {
    if (fecthedNews == null) {
      await news(choosenAccount!.userId, choosenAccount!.cookie)
          .then((value) async {
        fecthedNews = value;
        update();
      });
    }
  }

  bool activeBanner = true;
  changeHideBanner(bool newBanner) {
    activeBanner = newBanner;
    update();
  }

  RxBool tabOpen = true.obs;
  changeTabOpen(bool open) {
    tabOpen.value = open;
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  void onRefresh() async {
    // monitor network fetch
    await refreshAccount();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  Future refreshAccount() async {
    await getPrefs();
    try {
      await Get.find<StoriesController>().getStories(true);
    } catch (e) {
      await Get.put(StoriesController()).getStories(true);
    }
  }

  addFollowing(FollowerUsers followingUser) {
    FollowingUsers user = FollowingUsers(
        pk: followingUser.pk,
        username: followingUser.username,
        fullName: followingUser.fullName,
        isPrivate: followingUser.isPrivate,
        profilePicUrl: followingUser.profilePicUrl,
        profilePicId: followingUser.profilePicId,
        isVerified: followingUser.isVerified,
        hasAnonymousProfilePicture: followingUser.hasAnonymousProfilePicture,
        hasHighlightReels: followingUser.hasHighlightReels,
        accountBadges: followingUser.accountBadges,
        similarUserId: followingUser.similarUserId,
        latestReelMedia: followingUser.latestReelMedia,
        isFavorite: followingUser.isFavorite,
        stillFollowing: true,
        timestamp: DateTime.now());
    followings.add(user);
    followingIds.add(followingUser.pk.toString());
    update();
  }

  addFollowingPostUser(PostUser postUser) {
    FollowingUsers user = FollowingUsers(
        pk: int.parse(postUser.data.user.id!),
        username: postUser.data.user.username,
        fullName: postUser.data.user.fullName,
        isPrivate: postUser.data.user.isPrivate,
        profilePicUrl: postUser.data.user.profilePicUrl,
        profilePicId: "",
        isVerified: postUser.data.user.isVerified,
        hasAnonymousProfilePicture: null,
        hasHighlightReels:
            postUser.data.user.highlightReelCount! > 0 ? true : false,
        accountBadges: [],
        similarUserId: postUser.data.user.id,
        latestReelMedia: null,
        isFavorite: null,
        stillFollowing: true,
        timestamp: DateTime.now());
    followings.add(user);
    followingIds.add(postUser.data.user.id.toString());
    update();
  }

  addFollowingSearchUser(SearchUser searchUser) {
    FollowingUsers user = FollowingUsers(
        pk: int.parse(searchUser.user.pk!),
        username: searchUser.user.username,
        fullName: searchUser.user.fullName,
        isPrivate: searchUser.user.isPrivate,
        profilePicUrl: searchUser.user.profilePicUrl,
        profilePicId: searchUser.user.profilePicId,
        isVerified: searchUser.user.isVerified,
        hasAnonymousProfilePicture: searchUser.user.hasAnonymousProfilePicture,
        hasHighlightReels: searchUser.user.hasHighlightReels,
        accountBadges: [],
        similarUserId: null,
        latestReelMedia: searchUser.user.latestReelMedia,
        isFavorite: null,
        stillFollowing: true,
        timestamp: DateTime.now());
    followings.add(user);
    followingIds.add(searchUser.user.pk.toString());
    update();
  }

  removeFollowing(FollowerUsers followingUser) {
    followings.removeWhere(
        (user) => user.pk.toString() == followingUser.pk.toString());
    followingIds.remove(followingUser.pk.toString());
    update();
  }

  removeFollowingPostUser(PostUser postUser) {
    followings.removeWhere((user) =>
        postUser.data.user.id.toString() == postUser.data.user.id.toString());
    followingIds.remove(postUser.data.user.id.toString());
    update();
  }

  removeFollowingSearchUser(SearchUser searchUser) {
    followings.removeWhere(
        (user) => user.pk!.toString() == searchUser.user.pk.toString());
    followingIds.remove(searchUser.user.pk.toString());
    update();
  }

  Future invalidToken(Account account, [bool notRedirect = false]) async {
    showToast(
      "Fetch Failed",
    );
    final accountBox = Boxes.getAccounts();
    accountBox.delete(account.userId);
    if (notRedirect) {
      Get.offAll(Login());
    }
  }

  Future<bool> getInfo([bool notRedirect = false]) async {
    var completer = Completer<bool>();
    await info(choosenAccount!.userId, choosenAccount!.cookie)
        .then((value) async {
      user = value;
      if (user == null) {
        await invalidToken(choosenAccount!, notRedirect);
        completer.complete(false);
      } else {
        final accountBox = Boxes.getAccounts();
        choosenAccount!.username = user!.user.username;
        choosenAccount!.photoUrl = user!.user.profilePicUrl;
        accountBox.put(choosenAccount!.userId, choosenAccount!);

        completer.complete(true);
      }
      update();
    });
    return completer.future;
  }

  String nextMaxidFollowers = '';
  Future getUserFollowers() async {
    await getFollowers(
            choosenAccount!.userId, choosenAccount!.cookie, nextMaxidFollowers)
        .then((value) async {
      if (value != null) {
        followers.addAll(value.users);
        if (value.nextMaxId != null && value.nextMaxId != '') {
          nextMaxidFollowers = value.nextMaxId!;
          getUserFollowers();
        } else {
          followersIds =
              followers.map((element) => element.pk.toString()).toList();
          SharedPreferences preferences = await SharedPreferences.getInstance();
          if (preferences.getStringList("followers${choosenAccount!.userId}") ==
              null) {
            firstFollowersIds = followersIds.map((e) => e.toString()).toList();
            preferences.setStringList(
                "followers${choosenAccount!.userId}", firstFollowersIds);
          } else {
            firstFollowersIds = preferences
                    .getStringList("followers${choosenAccount!.userId}") ??
                [];
          }

          final followersBox = Boxes.getFollowers();
          for (var follower in followers) {
            if (followersBox.containsKey(follower.pk.toString())) {
            } else {
              follower.userIdForAccount = choosenAccount!.userId;
              followersBox.put(follower.pk.toString(), follower);
            }
          }
          countLostFollowers();
          loadingFollowers = false;
          update();
        }
      }
    });
  }

  String nextMaxidFollowings = '';
  Future getUserFollowings() async {
    await getFollowings(
            choosenAccount!.userId, choosenAccount!.cookie, nextMaxidFollowings)
        .then((value) async {
      if (value != null) {
        followings.addAll(value.users);
        if (value.nextMaxId != null && value.nextMaxId != '') {
          nextMaxidFollowings = value.nextMaxId!;
          getUserFollowings();
        } else {
          followingIds =
              followings.map((element) => element.pk.toString()).toList();
          final followingsBox = Boxes.getFollowings();
          SharedPreferences preferences = await SharedPreferences.getInstance();
          if (preferences
                  .getStringList("followings${choosenAccount!.userId}") ==
              null) {
            firstFollowingIds = followingIds.map((e) => e.toString()).toList();
            preferences.setStringList(
                "followings${choosenAccount!.userId}", firstFollowingIds);
          } else {
            firstFollowingIds = preferences
                    .getStringList("followings${choosenAccount!.userId}") ??
                [];
          }

          for (var following in followings) {
            if (followingsBox.containsKey(following.pk.toString())) {
            } else {
              following.userIdForAccount = choosenAccount!.userId;
              followingsBox.put(following.pk.toString(), following);
            }
          }
          countLostFollowings();
          loadingFollowings = false;
          update();
        }
      }
    });
  }

  bool loadingFollowers = true;
  bool loadingFollowings = true;
  bool lostFollowers = true;
  bool lostFollowings = true;
  countLostFollowers() async {
    final followersBox = Boxes.getFollowers();
    final hiveFollowerIds = Boxes.getFollowers()
        .values
        .toList()
        .where((element) => element.userIdForAccount == choosenAccount!.userId)
        .toList()
        .map((e) => e.pk.toString())
        .toList();

    for (var hiveFollower in hiveFollowerIds) {
      if (!followersIds.contains(hiveFollower)) {
        FollowerUsers followerUsers = Boxes.getFollowers()
            .values
            .toList()
            .where((element) => element.pk.toString() == hiveFollower)
            .first;
        followerUsers.stillFollower = false;

        followersBox.put(hiveFollower, followerUsers);
      } else if (followersBox.get(hiveFollower)!.stillFollower == false) {
        FollowerUsers followerUsers = Boxes.getFollowers()
            .values
            .toList()
            .where((element) => element.pk.toString() == hiveFollower)
            .first;
        followerUsers.stillFollower = true;
        followersBox.put(hiveFollower, followerUsers);
      }
    }
    lostFollowers = false;
    update();
  }

  List blockedUsers = [];
  Future checkBlockMe(String userId) async {
    await info(userId, choosenAccount!.cookie).then((value) async {
      if (value == null) {
        blockedUsers.add(userId);
      }
      update();
    });
  }

  bool loadingBlocks = true;
  countBlocks() async {
    List<FollowerUsers> unfollowers = Boxes.getFollowers()
        .values
        .toList()
        .where((element) =>
            element.userIdForAccount != null &&
            element.userIdForAccount == choosenAccount!.userId &&
            DateTime.now().difference(element.timestamp).inHours < 24 &&
            !element.stillFollower)
        .toList();
    for (var user in unfollowers) {
      await checkBlockMe(user.pk.toString());
    }
    loadingBlocks = false;
  }

  countLostFollowings() {
    final followingsBox = Boxes.getFollowings();
    final hiveFollowingsIds = Boxes.getFollowings()
        .values
        .toList()
        .where((element) => element.userIdForAccount == choosenAccount!.userId)
        .toList()
        .map((e) => e.pk.toString())
        .toList();

    for (var hiveFollowing in hiveFollowingsIds) {
      if (!followingIds.contains(hiveFollowing)) {
        FollowingUsers followingUser = Boxes.getFollowings()
            .values
            .toList()
            .where(
                (element) => element.pk.toString() == hiveFollowing.toString())
            .first;
        followingUser.stillFollowing = false;
        followingsBox.put(hiveFollowing, followingUser);
      } else {
        FollowingUsers followingUser = Boxes.getFollowings()
            .values
            .toList()
            .where(
                (element) => element.pk.toString() == hiveFollowing.toString())
            .first;
        followingUser.stillFollowing = true;
        followingsBox.put(hiveFollowing, followingUser);
      }
    }
    lostFollowings = false;
    update();
  }

  initializeAndroidAlarmManager() async {
    await AndroidAlarmManager.initialize();
    await AndroidAlarmManager.periodic(
            Duration(minutes: RemoteConfigService().notificationInterval),
            0,
            fetchStoriesAndSendNoti)
        .then((value) {});
    // await AndroidAlarmManager.periodic(
    //         Duration(seconds: 3), 0, fetchStoryViewsAndSendNoti)
    //     .then((value) {
    //   print('fetchStoryViewsAndSendNoti setted: $value');
    // });
  }

  // static Future fetchStoryViewsAndSendNoti() async {
  //   PathProviderAndroid.registerWith();
  //   SharedPreferencesAndroid.registerWith();
  //   try {
  //     await Hive.initFlutter();
  //     SharedPreferencesAndroid.registerWith();
  //     Hive.registerAdapter(AccountAdapter());
  //     Hive.registerAdapter(StoryAdapter());
  //     await Hive.openBox<Story>("stories");
  //     await Hive.openBox<Account>("accounts");
  //   } catch (e) {
  //     print(e);
  //   }
  //   SharedPreferences pref = await SharedPreferences.getInstance();

  //   final accountsBox = Boxes.getAccounts();
  //   List<Account> accounts = accountsBox.values.toList();
  //   if (accounts.isNotEmpty) {
  //     for (var choosenAccount in accounts) {
  //       await storyViews(item.pk.toString(), choosenAccount.cookie,
  //               choosenAccount.csrfToken)
  //           .then((value) {
  //         if (value != null) {
  //           storyView = value;
  //         }
  //       });
  //       await news(choosenAccount.userId, choosenAccount.cookie)
  //           .then((value) async {
  //         News? fecthedNews = value;
  //         if (fecthedNews != null) {
  //           List<Story>? oldStories = fecthedNews.oldStories;
  //           List<Story>? newStories = fecthedNews.newStories;
  //           List<String> notifiedList =
  //               pref.getStringList('notifiedList') ?? [];
  //           for (var story in newStories!) {
  //             if (!notifiedList.contains(story.pk)) {
  //               Notifications().showNotificationMediaStyle(
  //                   story.args!.profileName.toString(),
  //                   story.args!.text!
  //                       .toString()
  //                       .replaceAll("${story.args!.profileName}", "")
  //                       .toString(),
  //                   story.args!.profileImage!);
  //               notifiedList.add(story.pk.toString());
  //               pref.setStringList("notifiedList", notifiedList);
  //             } else {
  //               print('zaten listede var');
  //             }
  //           }
  //         }
  //       });
  //     }
  //   }
  // }

  static Future fetchStoriesAndSendNoti() async {
    PathProviderAndroid.registerWith();
    SharedPreferencesAndroid.registerWith();
    try {
      await Firebase.initializeApp();
      await Hive.initFlutter();
      SharedPreferencesAndroid.registerWith();
      Hive.registerAdapter(AccountAdapter());
      Hive.registerAdapter(StoryAdapter());
      await Hive.openBox<Story>("stories");
      await Hive.openBox<Account>("accounts");
    } catch (e) {
      print(e);
    }
    SharedPreferences pref = await SharedPreferences.getInstance();

    final accountsBox = Boxes.getAccounts();
    List<Account> accounts = accountsBox.values.toList();
    if (accounts.isNotEmpty) {
      for (var choosenAccount in accounts) {
        await news(choosenAccount.userId, choosenAccount.cookie)
            .then((value) async {
          News? fecthedNews = value;
          if (fecthedNews != null) {
            List<Story>? oldStories = fecthedNews.oldStories;
            List<Story>? newStories = fecthedNews.newStories;
            List<String> notifiedList =
                pref.getStringList('notifiedList') ?? [];
            for (var story in newStories!) {
              if (!notifiedList.contains(story.pk)) {
                Notifications().showNotificationMediaStyle(
                    story.args!.profileName.toString(),
                    story.args!.text!
                        .toString()
                        .replaceAll("${story.args!.profileName}", "")
                        .toString(),
                    story.args!.profileImage!);
                notifiedList.add(story.pk.toString());
                pref.setStringList("notifiedList", notifiedList);
              } else {
                print('zaten listede var');
              }
            }
          }
        });
      }
    }
  }
}
