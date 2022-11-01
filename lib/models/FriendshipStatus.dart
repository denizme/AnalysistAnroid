// To parse this JSON data, do
//
//     final friendshipStatus = friendshipStatusFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FriendshipStatus friendshipStatusFromJson(String str) =>
    FriendshipStatus.fromJson(json.decode(str));

String friendshipStatusToJson(FriendshipStatus data) =>
    json.encode(data.toJson());

class FriendshipStatus {
  FriendshipStatus({
    required this.blocking,
    required this.followedBy,
    required this.following,
    required this.incomingRequest,
    required this.isBestie,
    required this.isBlockingReel,
    required this.isMutingReel,
    required this.isPrivate,
    required this.isRestricted,
    required this.muting,
    required this.outgoingRequest,
    required this.isFeedFavorite,
    required this.subscribed,
    required this.isEligibleToSubscribe,
    required this.isSupervisedByViewer,
    required this.isGuardianOfViewer,
    required this.status,
  });

  final bool blocking;
  final bool followedBy;
  final bool following;
  final bool incomingRequest;
  final bool isBestie;
  final bool isBlockingReel;
  final bool isMutingReel;
  final bool isPrivate;
  final bool isRestricted;
  final bool muting;
  final bool outgoingRequest;
  final bool isFeedFavorite;
  final bool subscribed;
  final bool isEligibleToSubscribe;
  final bool isSupervisedByViewer;
  final bool isGuardianOfViewer;
  final String status;

  factory FriendshipStatus.fromJson(Map<String, dynamic> json) =>
      FriendshipStatus(
        blocking: json["blocking"] == null ? null : json["blocking"],
        followedBy: json["followed_by"] == null ? null : json["followed_by"],
        following: json["following"] == null ? null : json["following"],
        incomingRequest:
            json["incoming_request"] == null ? null : json["incoming_request"],
        isBestie: json["is_bestie"] == null ? null : json["is_bestie"],
        isBlockingReel:
            json["is_blocking_reel"] == null ? null : json["is_blocking_reel"],
        isMutingReel:
            json["is_muting_reel"] == null ? null : json["is_muting_reel"],
        isPrivate: json["is_private"] == null ? null : json["is_private"],
        isRestricted:
            json["is_restricted"] == null ? null : json["is_restricted"],
        muting: json["muting"] == null ? null : json["muting"],
        outgoingRequest:
            json["outgoing_request"] == null ? null : json["outgoing_request"],
        isFeedFavorite:
            json["is_feed_favorite"] == null ? null : json["is_feed_favorite"],
        subscribed: json["subscribed"] == null ? null : json["subscribed"],
        isEligibleToSubscribe: json["is_eligible_to_subscribe"] == null
            ? null
            : json["is_eligible_to_subscribe"],
        isSupervisedByViewer: json["is_supervised_by_viewer"] == null
            ? null
            : json["is_supervised_by_viewer"],
        isGuardianOfViewer: json["is_guardian_of_viewer"] == null
            ? null
            : json["is_guardian_of_viewer"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "blocking": blocking == null ? null : blocking,
        "followed_by": followedBy == null ? null : followedBy,
        "following": following == null ? null : following,
        "incoming_request": incomingRequest == null ? null : incomingRequest,
        "is_bestie": isBestie == null ? null : isBestie,
        "is_blocking_reel": isBlockingReel == null ? null : isBlockingReel,
        "is_muting_reel": isMutingReel == null ? null : isMutingReel,
        "is_private": isPrivate == null ? null : isPrivate,
        "is_restricted": isRestricted == null ? null : isRestricted,
        "muting": muting == null ? null : muting,
        "outgoing_request": outgoingRequest == null ? null : outgoingRequest,
        "is_feed_favorite": isFeedFavorite == null ? null : isFeedFavorite,
        "subscribed": subscribed == null ? null : subscribed,
        "is_eligible_to_subscribe":
            isEligibleToSubscribe == null ? null : isEligibleToSubscribe,
        "is_supervised_by_viewer":
            isSupervisedByViewer == null ? null : isSupervisedByViewer,
        "is_guardian_of_viewer":
            isGuardianOfViewer == null ? null : isGuardianOfViewer,
        "status": status == null ? null : status,
      };
}
