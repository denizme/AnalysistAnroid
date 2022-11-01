// To parse this JSON data, do
//
//     final searchUser = searchUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchUser searchUserFromJson(String str) =>
    SearchUser.fromJson(json.decode(str));

String searchUserToJson(SearchUser data) => json.encode(data.toJson());

class SearchUser {
  SearchUser({
    required this.position,
    required this.user,
  });

  final int position;
  final SearchedUser user;

  factory SearchUser.fromJson(Map<String, dynamic> json) => SearchUser(
        position: json["position"] == null ? null : json["position"],
        user: SearchedUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "position": position == null ? null : position,
        "user": user == null ? null : user.toJson(),
      };
}

class SearchedUser {
  SearchedUser({
    required this.pk,
    required this.username,
    required this.fullName,
    required this.isPrivate,
    required this.profilePicUrl,
    required this.profilePicId,
    required this.isVerified,
    required this.hasAnonymousProfilePicture,
    required this.hasHighlightReels,
    required this.hasOptEligibleShop,
    required this.accountBadges,
    required this.friendshipStatus,
    required this.latestReelMedia,
    required this.liveBroadcastId,
    required this.shouldShowCategory,
    required this.seen,
  });

  final String? pk;
  final String? username;
  final String? fullName;
  final bool? isPrivate;
  final String? profilePicUrl;
  final String? profilePicId;
  final bool? isVerified;
  final bool? hasAnonymousProfilePicture;
  final bool? hasHighlightReels;
  final bool? hasOptEligibleShop;
  final List<dynamic>? accountBadges;
  final FriendshipStatus? friendshipStatus;
  final int? latestReelMedia;
  final dynamic liveBroadcastId;
  final bool? shouldShowCategory;
  final int? seen;

  factory SearchedUser.fromJson(Map<String, dynamic> json) => SearchedUser(
        pk: json["pk"] == null ? null : json["pk"],
        username: json["username"] == null ? null : json["username"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        isPrivate: json["is_private"] == null ? null : json["is_private"],
        profilePicUrl:
            json["profile_pic_url"] == null ? null : json["profile_pic_url"],
        profilePicId:
            json["profile_pic_id"] == null ? null : json["profile_pic_id"],
        isVerified: json["is_verified"] == null ? null : json["is_verified"],
        hasAnonymousProfilePicture:
            json["has_anonymous_profile_picture"] == null
                ? null
                : json["has_anonymous_profile_picture"],
        hasHighlightReels: json["has_highlight_reels"] == null
            ? null
            : json["has_highlight_reels"],
        hasOptEligibleShop: json["has_opt_eligible_shop"] == null
            ? null
            : json["has_opt_eligible_shop"],
        accountBadges: json["account_badges"] == null
            ? null
            : List<dynamic>.from(json["account_badges"].map((x) => x)),
        friendshipStatus: json["friendship_status"] == null
            ? null
            : FriendshipStatus.fromJson(json["friendship_status"]),
        latestReelMedia: json["latest_reel_media"] == null
            ? null
            : json["latest_reel_media"],
        liveBroadcastId: json["live_broadcast_id"],
        shouldShowCategory: json["should_show_category"] == null
            ? null
            : json["should_show_category"],
        seen: json["seen"] == null ? null : json["seen"],
      );

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
        "has_opt_eligible_shop":
            hasOptEligibleShop == null ? null : hasOptEligibleShop,
        "account_badges": accountBadges == null
            ? null
            : List<dynamic>.from(accountBadges!.map((x) => x)),
        "friendship_status":
            friendshipStatus == null ? null : friendshipStatus!.toJson(),
        "latest_reel_media": latestReelMedia == null ? null : latestReelMedia,
        "live_broadcast_id": liveBroadcastId,
        "should_show_category":
            shouldShowCategory == null ? null : shouldShowCategory,
        "seen": seen == null ? null : seen,
      };
}

class FriendshipStatus {
  FriendshipStatus({
    required this.following,
    required this.isPrivate,
    required this.incomingRequest,
    required this.outgoingRequest,
    required this.isBestie,
    required this.isRestricted,
    required this.isFeedFavorite,
  });

  final bool following;
  final bool isPrivate;
  final bool incomingRequest;
  final bool outgoingRequest;
  final bool isBestie;
  final bool isRestricted;
  final bool isFeedFavorite;

  factory FriendshipStatus.fromJson(Map<String, dynamic> json) =>
      FriendshipStatus(
        following: json["following"] == null ? null : json["following"],
        isPrivate: json["is_private"] == null ? null : json["is_private"],
        incomingRequest:
            json["incoming_request"] == null ? null : json["incoming_request"],
        outgoingRequest:
            json["outgoing_request"] == null ? null : json["outgoing_request"],
        isBestie: json["is_bestie"] == null ? null : json["is_bestie"],
        isRestricted:
            json["is_restricted"] == null ? null : json["is_restricted"],
        isFeedFavorite:
            json["is_feed_favorite"] == null ? null : json["is_feed_favorite"],
      );

  Map<String, dynamic> toJson() => {
        "following": following == null ? null : following,
        "is_private": isPrivate == null ? null : isPrivate,
        "incoming_request": incomingRequest == null ? null : incomingRequest,
        "outgoing_request": outgoingRequest == null ? null : outgoingRequest,
        "is_bestie": isBestie == null ? null : isBestie,
        "is_restricted": isRestricted == null ? null : isRestricted,
        "is_feed_favorite": isFeedFavorite == null ? null : isFeedFavorite,
      };
}
