// To parse this JSON data, do
//
//     final highlighted = highlightedFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Highlighted {
  Highlighted({
    required this.edgeHighlightReels,
  });

  final EdgeHighlightReels edgeHighlightReels;

  factory Highlighted.fromJson(Map<String, dynamic> json) => Highlighted(
        edgeHighlightReels:
            EdgeHighlightReels.fromJson(json["edge_highlight_reels"]),
      );
}

class EdgeHighlightReels {
  EdgeHighlightReels({
    required this.edges,
  });

  final List<HighlightEdge> edges;

  factory EdgeHighlightReels.fromJson(Map<String, dynamic> json) =>
      EdgeHighlightReels(
        edges: List<HighlightEdge>.from(
            json["edges"].map((x) => HighlightEdge.fromJson(x))),
      );
}

class HighlightEdge {
  HighlightEdge({
    required this.node,
  });

  final Node? node;

  factory HighlightEdge.fromJson(Map<String, dynamic> json) => HighlightEdge(
        node: json["node"] == null ? null : Node.fromJson(json["node"]),
      );
}

class Node {
  Node({
    required this.typename,
    required this.id,
    required this.coverMedia,
    required this.coverMediaCroppedThumbnail,
    required this.owner,
    required this.title,
  });

  final String? typename;
  final String? id;
  final CoverMedia? coverMedia;
  final CoverMediaCroppedThumbnail? coverMediaCroppedThumbnail;
  final Owner? owner;
  final String? title;

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        typename: json["__typename"] == null ? null : json["__typename"],
        id: json["id"] == null ? null : json["id"],
        coverMedia: json["cover_media"] == null
            ? null
            : CoverMedia.fromJson(json["cover_media"]),
        coverMediaCroppedThumbnail:
            json["cover_media_cropped_thumbnail"] == null
                ? null
                : CoverMediaCroppedThumbnail.fromJson(
                    json["cover_media_cropped_thumbnail"]),
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        title: json["title"] == null ? null : json["title"],
      );
}

class CoverMedia {
  CoverMedia({
    required this.thumbnailSrc,
  });

  final String thumbnailSrc;

  factory CoverMedia.fromJson(Map<String, dynamic> json) => CoverMedia(
        thumbnailSrc:
            json["thumbnail_src"] == null ? null : json["thumbnail_src"],
      );

  Map<String, dynamic> toJson() => {
        "thumbnail_src": thumbnailSrc == null ? null : thumbnailSrc,
      };
}

class CoverMediaCroppedThumbnail {
  CoverMediaCroppedThumbnail({
    required this.url,
  });

  final String url;

  factory CoverMediaCroppedThumbnail.fromJson(Map<String, dynamic> json) =>
      CoverMediaCroppedThumbnail(
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
      };
}

class Owner {
  Owner({
    required this.typename,
    required this.id,
    required this.profilePicUrl,
    required this.username,
  });

  final String? typename;
  final String id;
  final String? profilePicUrl;
  final String? username;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        typename: json["__typename"] == null ? null : json["__typename"],
        id: json["id"] == null ? null : json["id"],
        profilePicUrl:
            json["profile_pic_url"] == null ? null : json["profile_pic_url"],
        username: json["username"] == null ? null : json["username"],
      );
}

class Viewer {
  Viewer();

  factory Viewer.fromJson(Map<String, dynamic> json) => Viewer();

  Map<String, dynamic> toJson() => {};
}
