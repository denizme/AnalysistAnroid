// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString?);

import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

part 'News.g.dart';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String? newsToJson(News data) => json.encode(data.toJson());

class News {
  News({
    required this.aymf,
    required this.counts,
    required this.lastChecked,
    required this.priorityStories,
    required this.newStories,
    required this.oldStories,
    required this.continuationToken,
    required this.subscription,
    required this.isLastPage,
    required this.partition,
    required this.status,
  });

  final Aymf? aymf;
  final Map<String?, dynamic>? counts;
  final double? lastChecked;
  final List<dynamic>? priorityStories;
  final List<Story>? newStories;
  final List<Story>? oldStories;
  final dynamic continuationToken;
  final dynamic subscription;
  final bool? isLastPage;
  final Partition? partition;
  final String? status;

  factory News.fromJson(Map<String?, dynamic> json) => News(
        aymf: json["aymf"] == null ? null : Aymf.fromJson(json["aymf"]),
        counts: json["counts"] == null
            ? null
            : Map.from(json["counts"])
                .map((k, v) => MapEntry<String?, dynamic>(k, v)),
        lastChecked: json["last_checked"] == null
            ? null
            : json["last_checked"].toDouble(),
        priorityStories: json["priority_stories"] == null
            ? null
            : List<dynamic>.from(json["priority_stories"].map((x) => x)),
        newStories: json["new_stories"] == null
            ? null
            : List<Story>.from(
                json["new_stories"].map((x) => Story.fromJson(x))),
        oldStories: json["old_stories"] == null
            ? null
            : List<Story>.from(
                json["old_stories"].map((x) => Story.fromJson(x))),
        continuationToken: json["continuation_token"] == null
            ? null
            : json["continuation_token"],
        subscription: json["subscription"],
        isLastPage: json["is_last_page"] == null ? null : json["is_last_page"],
        partition: json["partition"] == null
            ? null
            : Partition.fromJson(json["partition"]),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String?, dynamic> toJson() => {
        "aymf": aymf == null ? null : aymf!.toJson(),
        "counts": counts == null
            ? null
            : Map.from(counts!).map((k, v) => MapEntry<String?, dynamic>(k, v)),
        "last_checked": lastChecked == null ? null : lastChecked,
        "priority_stories": priorityStories == null
            ? null
            : List<dynamic>.from(priorityStories!.map((x) => x)),
        "new_stories": newStories == null
            ? null
            : List<dynamic>.from(newStories!.map((x) => x.toJson())),
        "old_stories": oldStories == null
            ? null
            : List<dynamic>.from(oldStories!.map((x) => x.toJson())),
        "continuation_token":
            continuationToken == null ? null : continuationToken,
        "subscription": subscription,
        "is_last_page": isLastPage == null ? null : isLastPage,
        "partition": partition == null ? null : partition!.toJson(),
        "status": status == null ? null : status,
      };
}

class Aymf {
  Aymf({
    required this.items,
    required this.moreAvailable,
  });

  final List<Item>? items;
  final bool? moreAvailable;

  factory Aymf.fromJson(Map<String?, dynamic> json) => Aymf(
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        moreAvailable:
            json["more_available"] == null ? null : json["more_available"],
      );

  Map<String?, dynamic> toJson() => {
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "more_available": moreAvailable == null ? null : moreAvailable,
      };
}

class Item {
  Item({
    required this.user,
    required this.algorithm,
    required this.socialContext,
    required this.icon,
    required this.caption,
    required this.mediaIds,
    required this.thumbnailUrls,
    required this.largeUrls,
    required this.mediaInfos,
    required this.value,
    required this.isNewSuggestion,
    required this.uuid,
    required this.followedBy,
  });

  final ItemUser? user;
  final Algorithm? algorithm;
  final String? socialContext;
  final String? icon;
  final String? caption;
  final List<dynamic>? mediaIds;
  final List<dynamic>? thumbnailUrls;
  final List<dynamic>? largeUrls;
  final List<dynamic>? mediaInfos;
  final double? value;
  final bool? isNewSuggestion;
  final Uuid? uuid;
  final bool? followedBy;

  factory Item.fromJson(Map<String?, dynamic> json) => Item(
        user: json["user"] == null ? null : ItemUser.fromJson(json["user"]),
        algorithm: json["algorithm"] == null
            ? null
            : algorithmValues.map[json["algorithm"]],
        socialContext:
            json["social_context"] == null ? null : json["social_context"],
        icon: json["icon"] == null ? null : json["icon"],
        caption: json["caption"] == null ? null : json["caption"],
        mediaIds: json["media_ids"] == null
            ? null
            : List<dynamic>.from(json["media_ids"].map((x) => x)),
        thumbnailUrls: json["thumbnail_urls"] == null
            ? null
            : List<dynamic>.from(json["thumbnail_urls"].map((x) => x)),
        largeUrls: json["large_urls"] == null
            ? null
            : List<dynamic>.from(json["large_urls"].map((x) => x)),
        mediaInfos: json["media_infos"] == null
            ? null
            : List<dynamic>.from(json["media_infos"].map((x) => x)),
        value: json["value"] == null ? null : json["value"].toDouble(),
        isNewSuggestion: json["is_new_suggestion"] == null
            ? null
            : json["is_new_suggestion"],
        uuid: json["uuid"] == null ? null : uuidValues.map[json["uuid"]],
        followedBy: json["followed_by"] == null ? null : json["followed_by"],
      );

  Map<String?, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
        "algorithm":
            algorithm == null ? null : algorithmValues.reverse[algorithm],
        "social_context": socialContext == null ? null : socialContext,
        "icon": icon == null ? null : icon,
        "caption": caption == null ? null : caption,
        "media_ids": mediaIds == null
            ? null
            : List<dynamic>.from(mediaIds!.map((x) => x)),
        "thumbnail_urls": thumbnailUrls == null
            ? null
            : List<dynamic>.from(thumbnailUrls!.map((x) => x)),
        "large_urls": largeUrls == null
            ? null
            : List<dynamic>.from(largeUrls!.map((x) => x)),
        "media_infos": mediaInfos == null
            ? null
            : List<dynamic>.from(mediaInfos!.map((x) => x)),
        "value": value == null ? null : value,
        "is_new_suggestion": isNewSuggestion == null ? null : isNewSuggestion,
        "uuid": uuid == null ? null : uuidValues.reverse[uuid],
        "followed_by": followedBy == null ? null : followedBy,
      };
}

enum Algorithm { UNKNOWN }

final algorithmValues = EnumValues({"unknown": Algorithm.UNKNOWN});

class ItemUser {
  ItemUser({
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
  final List<dynamic>? accountBadges;

  factory ItemUser.fromJson(Map<String?, dynamic> json) => ItemUser(
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
        accountBadges: json["account_badges"] == null
            ? null
            : List<dynamic>.from(json["account_badges"].map((x) => x)),
      );

  Map<String?, dynamic> toJson() => {
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
            : List<dynamic>.from(accountBadges!.map((x) => x)),
      };
}

enum Uuid { THE_545969478671662974987 }

final uuidValues =
    EnumValues({"54596947867|1662974987": Uuid.THE_545969478671662974987});

@HiveType(typeId: 3)
class Story {
  Story({
    required this.type,
    required this.storyType,
    required this.args,
    required this.counts,
    required this.pk,
  });
  @HiveField(0)
  final dynamic type;
  @HiveField(1)
  final dynamic storyType;
  @HiveField(2)
  final Args? args;
  @HiveField(3)
  final Counts? counts;
  @HiveField(4)
  final String? pk;

  factory Story.fromJson(Map<String?, dynamic> json) => Story(
        type: json["type"] == null ? null : json["type"],
        storyType: json["story_type"] == null ? null : json["story_type"],
        args: json["args"] == null ? null : Args.fromJson(json["args"]),
        counts: json["counts"] == null ? null : Counts.fromJson(json["counts"]),
        pk: json["pk"] == null ? null : json["pk"],
      );

  Map<String?, dynamic> toJson() => {
        "type": type == null ? null : type,
        "story_type": storyType == null ? null : storyType,
        "args": args == null ? null : args!.toJson(),
        "counts": counts == null ? null : counts!.toJson(),
        "pk": pk == null ? null : pk,
      };
}

class Args {
  Args({
    required this.text,
    required this.links,
    required this.profileId,
    required this.profileImage,
    required this.destination,
    required this.timestamp,
    required this.tuuid,
    required this.afCandidateId,
    required this.profileName,
    required this.latestReelMedia,
    required this.latestReelSeenTime,
    required this.users,
    required this.inlineFollow,
  });

  final String? text;
  final List<Link>? links;
  final dynamic profileId;
  final String? profileImage;
  final String? destination;
  final double? timestamp;
  final String? tuuid;
  final dynamic afCandidateId;
  final String? profileName;
  final dynamic latestReelMedia;
  final dynamic latestReelSeenTime;
  final List<UserElement>? users;
  final InlineFollow? inlineFollow;

  factory Args.fromJson(Map<String?, dynamic> json) => Args(
        text: json["text"] == null ? null : json["text"],
        links: json["links"] == null
            ? null
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        profileId: json["profile_id"] == null ? null : json["profile_id"],
        profileImage:
            json["profile_image"] == null ? null : json["profile_image"],
        destination: json["destination"] == null ? null : json["destination"],
        timestamp:
            json["timestamp"] == null ? null : json["timestamp"].toDouble(),
        tuuid: json["tuuid"] == null ? null : json["tuuid"],
        afCandidateId:
            json["af_candidate_id"] == null ? null : json["af_candidate_id"],
        profileName: json["profile_name"] == null ? null : json["profile_name"],
        latestReelMedia: json["latest_reel_media"] == null
            ? null
            : json["latest_reel_media"],
        latestReelSeenTime: json["latest_reel_seen_time"] == null
            ? null
            : json["latest_reel_seen_time"],
        users: json["users"] == null
            ? null
            : List<UserElement>.from(
                json["users"].map((x) => UserElement.fromJson(x))),
        inlineFollow: json["inline_follow"] == null
            ? null
            : InlineFollow.fromJson(json["inline_follow"]),
      );

  Map<String?, dynamic> toJson() => {
        "text": text == null ? null : text,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "profile_id": profileId == null ? null : profileId,
        "profile_image": profileImage == null ? null : profileImage,
        "destination": destination == null ? null : destination,
        "timestamp": timestamp == null ? null : timestamp,
        "tuuid": tuuid == null ? null : tuuid,
        "af_candidate_id": afCandidateId == null ? null : afCandidateId,
        "profile_name": profileName == null ? null : profileName,
        "latest_reel_media": latestReelMedia == null ? null : latestReelMedia,
        "latest_reel_seen_time":
            latestReelSeenTime == null ? null : latestReelSeenTime,
        "users": users == null
            ? null
            : List<dynamic>.from(users!.map((x) => x.toJson())),
        "inline_follow": inlineFollow == null ? null : inlineFollow!.toJson(),
      };
}

class InlineFollow {
  InlineFollow({
    required this.userInfo,
    required this.following,
    required this.outgoingRequest,
  });

  final UserInfo? userInfo;
  final bool? following;
  final bool? outgoingRequest;

  factory InlineFollow.fromJson(Map<String?, dynamic> json) => InlineFollow(
        userInfo: json["user_info"] == null
            ? null
            : UserInfo.fromJson(json["user_info"]),
        following: json["following"] == null ? null : json["following"],
        outgoingRequest:
            json["outgoing_request"] == null ? null : json["outgoing_request"],
      );

  Map<String?, dynamic> toJson() => {
        "user_info": userInfo == null ? null : userInfo!.toJson(),
        "following": following == null ? null : following,
        "outgoing_request": outgoingRequest == null ? null : outgoingRequest,
      };
}

class UserInfo {
  UserInfo({
    required this.id,
    required this.username,
    required this.isPrivate,
    required this.profilePicUrl,
  });

  final dynamic id;
  final String? username;
  final bool? isPrivate;
  final String? profilePicUrl;

  factory UserInfo.fromJson(Map<String?, dynamic> json) => UserInfo(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        isPrivate: json["is_private"] == null ? null : json["is_private"],
        profilePicUrl:
            json["profile_pic_url"] == null ? null : json["profile_pic_url"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "is_private": isPrivate == null ? null : isPrivate,
        "profile_pic_url": profilePicUrl == null ? null : profilePicUrl,
      };
}

class Link {
  Link({
    required this.start,
    required this.end,
    required this.type,
    required this.id,
  });

  final dynamic start;
  final dynamic end;
  final Type? type;
  final String? id;

  factory Link.fromJson(Map<String?, dynamic> json) => Link(
        start: json["start"] == null ? null : json["start"],
        end: json["end"] == null ? null : json["end"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String?, dynamic> toJson() => {
        "start": start == null ? null : start,
        "end": end == null ? null : end,
        "type": type == null ? null : typeValues.reverse[type],
        "id": id == null ? null : id,
      };
}

enum Type { USER }

final typeValues = EnumValues({"user": Type.USER});

class UserElement {
  UserElement({
    required this.pk,
    required this.isVerified,
  });

  final dynamic pk;
  final bool? isVerified;

  factory UserElement.fromJson(Map<String?, dynamic> json) => UserElement(
        pk: json["pk"] == null ? null : json["pk"],
        isVerified: json["is_verified"] == null ? null : json["is_verified"],
      );

  Map<String?, dynamic> toJson() => {
        "pk": pk == null ? null : pk,
        "is_verified": isVerified == null ? null : isVerified,
      };
}

class Counts {
  Counts();

  factory Counts.fromJson(Map<String?, dynamic> json) => Counts();

  Map<String?, dynamic> toJson() => {};
}

class Partition {
  Partition({
    required this.timeBucket,
  });

  final TimeBucket? timeBucket;

  factory Partition.fromJson(Map<String?, dynamic> json) => Partition(
        timeBucket: json["time_bucket"] == null
            ? null
            : TimeBucket.fromJson(json["time_bucket"]),
      );

  Map<String?, dynamic> toJson() => {
        "time_bucket": timeBucket == null ? null : timeBucket!.toJson(),
      };
}

class TimeBucket {
  TimeBucket({
    required this.headers,
    required this.indices,
  });

  final List<String>? headers;
  final List<dynamic>? indices;

  factory TimeBucket.fromJson(Map<String?, dynamic> json) => TimeBucket(
        headers: json["headers"] == null
            ? null
            : List<String>.from(json["headers"].map((x) => x)),
        indices: json["indices"] == null
            ? null
            : List<dynamic>.from(json["indices"].map((x) => x)),
      );

  Map<String?, dynamic> toJson() => {
        "headers":
            headers == null ? null : List<dynamic>.from(headers!.map((x) => x)),
        "indices":
            indices == null ? null : List<dynamic>.from(indices!.map((x) => x)),
      };
}

class EnumValues<T> {
  Map<String?, T> map;
  Map<T, String?>? reverseMap;

  EnumValues(this.map);

  Map<T, String?> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
