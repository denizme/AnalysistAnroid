// To parse this JSON data, do
//
//     final storyView = storyViewFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StoryView storyViewFromJson(String str) => StoryView.fromJson(json.decode(str));

String storyViewToJson(StoryView data) => json.encode(data.toJson());

class StoryView {
  StoryView({
    required this.users,
    required this.nextMaxId,
    required this.userCount,
    required this.totalViewerCount,
    required this.viewers,
    required this.reactions,
    required this.status,
  });

  final List<dynamic>? users;
  final dynamic nextMaxId;
  final int? userCount;
  final int? totalViewerCount;
  final List<dynamic>? viewers;
  final List<dynamic>? reactions;
  final String? status;

  factory StoryView.fromJson(Map<String, dynamic> json) => StoryView(
        users: json["users"] == null
            ? null
            : List<dynamic>.from(json["users"].map((x) => x)),
        nextMaxId: json["next_max_id"],
        userCount: json["user_count"] == null ? null : json["user_count"],
        totalViewerCount: json["total_viewer_count"] == null
            ? null
            : json["total_viewer_count"],
        viewers: json["viewers"] == null
            ? null
            : List<dynamic>.from(json["viewers"].map((x) => x)),
        reactions: json["reactions"] == null
            ? null
            : List<dynamic>.from(json["reactions"].map((x) => x)),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "users":
            users == null ? null : List<dynamic>.from(users!.map((x) => x)),
        "next_max_id": nextMaxId,
        "user_count": userCount == null ? null : userCount,
        "total_viewer_count":
            totalViewerCount == null ? null : totalViewerCount,
        "viewers":
            viewers == null ? null : List<dynamic>.from(viewers!.map((x) => x)),
        "reactions": reactions == null
            ? null
            : List<dynamic>.from(reactions!.map((x) => x)),
        "status": status == null ? null : status,
      };
}
