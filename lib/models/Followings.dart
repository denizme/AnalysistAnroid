// To parse this JSON data, do
//
//     final followers = followersFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:analysist/ui/landing/user_controller.dart';
part 'Followings.g.dart';

Followings followingsFromJson(String str) =>
    Followings.fromJson(json.decode(str));

String followingsToJson(Followings data) => json.encode(data.toJson());

class Followings {
  Followings({
    required this.users,
    required this.bigList,
    required this.pageSize,
    required this.status,
    required this.nextMaxId,
  });

  final List<FollowingUsers> users;
  final bool bigList;
  final int pageSize;
  final String status;
  final String? nextMaxId;

  factory Followings.fromJson(Map<String, dynamic> json) => Followings(
        users: List<FollowingUsers>.from(
            json["users"].map((x) => FollowingUsers.fromJson(x))),
        bigList: json["big_list"] == null ? null : json["big_list"],
        pageSize: json["page_size"] == null ? null : json["page_size"],
        status: json["status"] == null ? null : json["status"],
        nextMaxId: json["next_max_id"] == null ? null : json["next_max_id"],
      );

  Map<String, dynamic> toJson() => {
        "users": users == null
            ? null
            : List<dynamic>.from(users.map((x) => x.toJson())),
        "big_list": bigList == null ? null : bigList,
        "page_size": pageSize == null ? null : pageSize,
        "status": status == null ? null : status,
      };
}

@HiveType(typeId: 1)
class FollowingUsers {
  FollowingUsers({
    required this.pk,
    required this.username,
    required this.fullName,
    required this.isPrivate,
    required this.profilePicUrl,
    required this.profilePicId,
    required this.isVerified,
    required this.hasAnonymousProfilePicture,
    required this.hasHighlightReels,
    required this.accountBadges,
    required this.similarUserId,
    required this.latestReelMedia,
    required this.isFavorite,
    required this.stillFollowing,
    required this.timestamp,
    this.linkedFbInfo,
    this.userIdForAccount,
  });
  @HiveField(0)
  final dynamic pk;
  @HiveField(1)
  final String? username;
  @HiveField(2)
  final String? fullName;
  @HiveField(3)
  final bool? isPrivate;
  @HiveField(4)
  final String? profilePicUrl;
  @HiveField(5)
  final String? profilePicId;
  @HiveField(6)
  final bool? isVerified;
  @HiveField(7)
  final bool? hasAnonymousProfilePicture;
  @HiveField(8)
  final bool? hasHighlightReels;
  @HiveField(9)
  final List<dynamic> accountBadges;
  @HiveField(10)
  final dynamic similarUserId;
  @HiveField(11)
  final dynamic latestReelMedia;
  @HiveField(12)
  final bool? isFavorite;
  @HiveField(13)
  final DateTime timestamp;
  @HiveField(14)
  bool stillFollowing;
  @HiveField(15)
  String? userIdForAccount;
  final LinkedFbInfo? linkedFbInfo;

  factory FollowingUsers.fromJson(Map<String, dynamic> json) => FollowingUsers(
      pk: json["pk"] == null ? null : json["pk"],
      username: json["username"] == null ? null : json["username"],
      fullName: json["full_name"] == null ? null : json["full_name"],
      isPrivate: json["is_private"] == null ? null : json["is_private"],
      profilePicUrl:
          json["profile_pic_url"] == null ? null : json["profile_pic_url"],
      profilePicId:
          json["profile_pic_id"] == null ? null : json["profile_pic_id"],
      isVerified: json["is_verified"] == null ? null : json["is_verified"],
      hasAnonymousProfilePicture: json["has_anonymous_profile_picture"] == null
          ? null
          : json["has_anonymous_profile_picture"],
      hasHighlightReels: json["has_highlight_reels"] == null
          ? null
          : json["has_highlight_reels"],
      accountBadges: List<dynamic>.from(json["account_badges"].map((x) => x)),
      similarUserId: json["similar_user_id"],
      latestReelMedia:
          json["latest_reel_media"] == null ? null : json["latest_reel_media"],
      isFavorite: json["is_favorite"] == null ? null : json["is_favorite"],
      linkedFbInfo: json["linked_fb_info"] == null
          ? null
          : LinkedFbInfo.fromJson(json["linked_fb_info"]),
      userIdForAccount: Get.find<UserController>().choosenAccount != null
          ? Get.find<UserController>().choosenAccount!.userId
          : null,
      stillFollowing: true,
      timestamp: DateTime.now());

  Map<String, dynamic> toJson() => {
        "pk": pk == null ? null : pk,
        "username": username == null ? null : username,
        "full_name": fullName == null ? null : fullName,
        "is_private": isPrivate == null ? null : isPrivate,
        "profile_pic_url": profilePicUrl == null ? null : profilePicUrl,
        "profile_pic_id": profilePicId == null ? null : profilePicId,
        "is_verified": isVerified == null ? null : isVerified,
        "has_anonymous_profile_picture": hasAnonymousProfilePicture == null
            ? null
            : hasAnonymousProfilePicture,
        "has_highlight_reels":
            hasHighlightReels == null ? null : hasHighlightReels,
        "account_badges": accountBadges == null
            ? null
            : List<dynamic>.from(accountBadges.map((x) => x)),
        "similar_user_id": similarUserId,
        "latest_reel_media": latestReelMedia == null ? null : latestReelMedia,
        "is_favorite": isFavorite == null ? null : isFavorite,
        "linked_fb_info": linkedFbInfo == null ? null : linkedFbInfo!.toJson(),
      };
}

class LinkedFbInfo {
  LinkedFbInfo({
    required this.linkedFbUser,
  });

  final LinkedFbUser linkedFbUser;

  factory LinkedFbInfo.fromJson(Map<String, dynamic> json) => LinkedFbInfo(
        linkedFbUser: LinkedFbUser.fromJson(json["linked_fb_user"]),
      );

  Map<String, dynamic> toJson() => {
        "linked_fb_user": linkedFbUser == null ? null : linkedFbUser.toJson(),
      };
}

class LinkedFbUser {
  LinkedFbUser({
    required this.id,
    required this.name,
    required this.isValid,
    required this.fbAccountCreationTime,
    required this.linkTime,
  });

  final String id;
  final String name;
  final bool isValid;
  final dynamic fbAccountCreationTime;
  final dynamic linkTime;

  factory LinkedFbUser.fromJson(Map<String, dynamic> json) => LinkedFbUser(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        isValid: json["is_valid"] == null ? null : json["is_valid"],
        fbAccountCreationTime: json["fb_account_creation_time"],
        linkTime: json["link_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "is_valid": isValid == null ? null : isValid,
        "fb_account_creation_time": fbAccountCreationTime,
        "link_time": linkTime,
      };
}
