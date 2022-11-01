// To parse this JSON data, do
//
//     final stories = storiesFromJson(jsonString);

import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<Stories> storiesFromJson(String str) =>
    List<Stories>.from(json.decode(str).map((x) => Stories.fromJson(x)));

class Stories {
  Stories({
    required this.user,
    required this.items,
    required this.id,
    required this.watched,
  });
  final dynamic id;
  bool watched;
  final User? user;
  final List<Item>? items;

  factory Stories.fromJson(Map<String, dynamic> json) => Stories(
        user: User.fromJson(json["user"]),
        id: json["id"],
        watched: false,
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

@HiveType(typeId: 6)
class Item {
  Item({
    required this.imageVersions2,
    required this.videoVersions,
    required this.pk,
    required this.takenAt,
  });

  final ImageVersions2? imageVersions2;
  var takenAt;
  final String? pk;
  final List<VideoVersion> videoVersions;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        imageVersions2: json["image_versions2"] == null
            ? null
            : ImageVersions2.fromJson(json["image_versions2"]),
        pk: json["pk"] ?? null,
        takenAt: json["taken_at"],
        videoVersions: json["video_versions"] == null
            ? []
            : List<VideoVersion>.from(
                json["video_versions"].map((x) => VideoVersion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "image_versions2":
            imageVersions2 == null ? null : imageVersions2!.toJson(),
        "video_versions": videoVersions == null
            ? []
            : List<dynamic>.from(videoVersions.map((x) => x.toJson())),
      };
}

class VideoVersion {
  VideoVersion({
    required this.type,
    required this.width,
    required this.height,
    required this.url,
    required this.id,
  });

  final dynamic type;
  final dynamic width;
  final dynamic height;
  final String url;
  final String id;

  factory VideoVersion.fromJson(Map<String, dynamic> json) => VideoVersion(
        type: json["type"] == null ? null : json["type"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        url: json["url"] == null ? null : json["url"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "url": url == null ? null : url,
        "id": id == null ? null : id,
      };
}

class ImageVersions2 {
  ImageVersions2({
    required this.candidates,
  });

  final List<Candidate> candidates;

  factory ImageVersions2.fromJson(Map<String, dynamic> json) => ImageVersions2(
        candidates: List<Candidate>.from(
            json["candidates"].map((x) => Candidate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "candidates": candidates == null
            ? null
            : List<dynamic>.from(candidates.map((x) => x.toJson())),
      };
}

class Candidate {
  Candidate({
    required this.width,
    required this.height,
    required this.url,
  });

  final dynamic width;
  final dynamic height;
  final String url;

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "url": url == null ? null : url,
      };
}

class User {
  User({
    required this.pk,
    required this.username,
    required this.fullName,
    required this.isPrivate,
    required this.profilePicUrl,
    required this.profilePicId,
    required this.isVerified,
    required this.friendshipStatus,
  });

  final dynamic pk;
  final String? username;
  final String? fullName;
  final bool? isPrivate;
  final String? profilePicUrl;
  final String? profilePicId;
  final bool? isVerified;
  final FriendshipStatus? friendshipStatus;

  factory User.fromJson(Map<String, dynamic> json) => User(
        pk: json["pk"] == null ? null : json["pk"],
        username: json["username"] == null ? null : json["username"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        isPrivate: json["is_private"] == null ? null : json["is_private"],
        profilePicUrl:
            json["profile_pic_url"] == null ? null : json["profile_pic_url"],
        profilePicId:
            json["profile_pic_id"] == null ? null : json["profile_pic_id"],
        isVerified: json["is_verified"] == null ? null : json["is_verified"],
        friendshipStatus: json["friendship_status"] == null
            ? null
            : FriendshipStatus.fromJson(json["friendship_status"]),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk == null ? null : pk,
        "username": username == null ? null : username,
        "full_name": fullName == null ? null : fullName,
        "is_private": isPrivate == null ? null : isPrivate,
        "profile_pic_url": profilePicUrl == null ? null : profilePicUrl,
        "profile_pic_id": profilePicId == null ? null : profilePicId,
        "is_verified": isVerified == null ? null : isVerified,
        "friendship_status":
            friendshipStatus == null ? null : friendshipStatus!.toJson(),
      };
}

class FriendshipStatus {
  FriendshipStatus({
    required this.muting,
    required this.isMutingReel,
    required this.following,
    required this.isBestie,
    required this.outgoingRequest,
  });

  final bool? muting;
  final bool? isMutingReel;
  final bool? following;
  final bool? isBestie;
  final bool? outgoingRequest;

  factory FriendshipStatus.fromJson(Map<String, dynamic> json) =>
      FriendshipStatus(
        muting: json["muting"] == null ? null : json["muting"],
        isMutingReel:
            json["is_muting_reel"] == null ? null : json["is_muting_reel"],
        following: json["following"] == null ? null : json["following"],
        isBestie: json["is_bestie"] == null ? null : json["is_bestie"],
        outgoingRequest:
            json["outgoing_request"] == null ? null : json["outgoing_request"],
      );

  Map<String, dynamic> toJson() => {
        "muting": muting == null ? null : muting,
        "is_muting_reel": isMutingReel == null ? null : isMutingReel,
        "following": following == null ? null : following,
        "is_bestie": isBestie == null ? null : isBestie,
        "outgoing_request": outgoingRequest == null ? null : outgoingRequest,
      };
}
