import 'package:hive/hive.dart';
import 'package:analysist/models/Account.dart';
import 'package:analysist/models/News.dart';
import '../models/Followers.dart';
import '../models/Followings.dart';

class Boxes {
  static Box<FollowerUsers> getFollowers() =>
      Hive.box<FollowerUsers>('followers');
  static Box<FollowingUsers> getFollowings() =>
      Hive.box<FollowingUsers>('followings');
  static Box<Account> getAccounts() => Hive.box<Account>('accounts');
  static Box<Story> getStories() => Hive.box<Story>('stories');
}
