import 'package:hive_flutter/hive_flutter.dart';

part 'Account.g.dart';

@HiveType(typeId: 2)
class Account {
  @HiveField(0)
  String userId;
  @HiveField(1)
  String cookie;
  @HiveField(2)
  String csrfToken;
  @HiveField(3)
  String? username;
  @HiveField(4)
  String? photoUrl;

  Account(
      {required this.userId,
      required this.cookie,
      required this.csrfToken,
      this.photoUrl,
      this.username});
}
