// To parse this JSON data, do
//
//     final postUser = postUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PostUser postUserFromJson(String str) => PostUser.fromJson(json.decode(str));

String postUserToJson(PostUser data) => json.encode(data.toJson());

class PostUser {
  PostUser({
    required this.data,
    required this.status,
  });

  final Data data;
  final String status;

  factory PostUser.fromJson(Map<String, dynamic> json) => PostUser(
        data: Data.fromJson(json["data"]),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "status": status == null ? null : status,
      };
}

class Data {
  Data({
    required this.user,
  });

  final DetailedUser user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: DetailedUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
      };
}

class DetailedUser {
  DetailedUser({
    required this.biography,
    required this.bioLinks,
    required this.biographyWithEntities,
    required this.blockedByViewer,
    required this.restrictedByViewer,
    required this.countryBlock,
    required this.externalUrl,
    required this.externalUrlLinkshimmed,
    required this.edgeFollowedBy,
    required this.fbid,
    required this.followedByViewer,
    required this.edgeFollow,
    required this.followsViewer,
    required this.fullName,
    required this.groupMetadata,
    required this.hasArEffects,
    required this.hasClips,
    required this.hasGuides,
    required this.hasChannel,
    required this.hasBlockedViewer,
    required this.highlightReelCount,
    required this.hasRequestedViewer,
    required this.hideLikeAndViewCounts,
    required this.id,
    required this.isBusinessAccount,
    required this.isEligibleToViewAccountTransparency,
    required this.isProfessionalAccount,
    required this.isSupervisionEnabled,
    required this.isGuardianOfViewer,
    required this.isSupervisedByViewer,
    required this.isSupervisedUser,
    required this.isEmbedsDisabled,
    required this.isJoinedRecently,
    required this.guardianId,
    required this.businessAddressJson,
    required this.businessContactMethod,
    required this.businessEmail,
    required this.businessPhoneNumber,
    required this.businessCategoryName,
    required this.overallCategoryName,
    required this.categoryEnum,
    required this.categoryName,
    required this.isPrivate,
    required this.isVerified,
    required this.edgeMutualFollowedBy,
    required this.profilePicUrl,
    required this.profilePicUrlHd,
    required this.requestedByViewer,
    required this.shouldShowCategory,
    required this.shouldShowPublicContacts,
    required this.stateControlledMediaCountry,
    required this.locationTransparencyCountry,
    required this.transparencyLabel,
    required this.transparencyProduct,
    required this.username,
    required this.connectedFbPage,
    required this.pronouns,
    required this.edgeFelixCombinedPostUploads,
    required this.edgeFelixCombinedDraftUploads,
    required this.edgeFelixVideoTimeline,
    required this.edgeFelixDrafts,
    required this.edgeFelixPendingPostUploads,
    required this.edgeFelixPendingDraftUploads,
    required this.edgeOwnerToTimelineMedia,
    required this.edgeSavedMedia,
    required this.edgeMediaCollections,
  });

  final String? biography;
  final List<dynamic>? bioLinks;
  final BiographyWithEntities? biographyWithEntities;
  final bool? blockedByViewer;
  final bool? restrictedByViewer;
  final bool? countryBlock;
  final dynamic externalUrl;
  final dynamic externalUrlLinkshimmed;
  final EdgeFollowClass? edgeFollowedBy;
  final String? fbid;
  final bool? followedByViewer;
  final EdgeFollowClass? edgeFollow;
  final bool? followsViewer;
  final String? fullName;
  final dynamic groupMetadata;
  final bool? hasArEffects;
  final bool? hasClips;
  final bool? hasGuides;
  final bool? hasChannel;
  final bool? hasBlockedViewer;
  final int? highlightReelCount;
  final bool? hasRequestedViewer;
  final bool? hideLikeAndViewCounts;
  final String? id;
  final bool? isBusinessAccount;
  final bool? isEligibleToViewAccountTransparency;
  final bool? isProfessionalAccount;
  final bool? isSupervisionEnabled;
  final bool? isGuardianOfViewer;
  final bool? isSupervisedByViewer;
  final bool? isSupervisedUser;
  final bool? isEmbedsDisabled;
  final bool? isJoinedRecently;
  final dynamic guardianId;
  final dynamic businessAddressJson;
  final String? businessContactMethod;
  final dynamic businessEmail;
  final dynamic businessPhoneNumber;
  final dynamic businessCategoryName;
  final dynamic overallCategoryName;
  final dynamic categoryEnum;
  final dynamic categoryName;
  final bool? isPrivate;
  final bool? isVerified;
  final EdgeMutualFollowedBy? edgeMutualFollowedBy;
  final String? profilePicUrl;
  final String? profilePicUrlHd;
  final bool? requestedByViewer;
  final bool? shouldShowCategory;
  final bool? shouldShowPublicContacts;
  final dynamic stateControlledMediaCountry;
  final dynamic locationTransparencyCountry;
  final dynamic transparencyLabel;
  final String? transparencyProduct;
  final String? username;
  final dynamic connectedFbPage;
  final List<dynamic>? pronouns;
  EdgeFelixCombinedDraftUploadsClass? edgeFelixCombinedPostUploads;
  final EdgeFelixCombinedDraftUploadsClass? edgeFelixCombinedDraftUploads;
  final EdgeFelixCombinedDraftUploadsClass? edgeFelixVideoTimeline;
  final EdgeFelixCombinedDraftUploadsClass? edgeFelixDrafts;
  final EdgeFelixCombinedDraftUploadsClass? edgeFelixPendingPostUploads;
  final EdgeFelixCombinedDraftUploadsClass? edgeFelixPendingDraftUploads;
  EdgeFelixCombinedDraftUploadsClass? edgeOwnerToTimelineMedia;
  final EdgeFelixCombinedDraftUploadsClass? edgeSavedMedia;
  final EdgeFelixCombinedDraftUploadsClass? edgeMediaCollections;

  factory DetailedUser.fromJson(Map<String, dynamic> json) => DetailedUser(
        biography: json["biography"] == null ? null : json["biography"],
        bioLinks: json["bio_links"] == null
            ? null
            : List<dynamic>.from(json["bio_links"].map((x) => x)),
        biographyWithEntities: json["biography_with_entities"] == null
            ? null
            : BiographyWithEntities.fromJson(json["biography_with_entities"]),
        blockedByViewer: json["blocked_by_viewer"] == null
            ? null
            : json["blocked_by_viewer"],
        restrictedByViewer: json["restricted_by_viewer"] == null
            ? null
            : json["restricted_by_viewer"],
        countryBlock:
            json["country_block"] == null ? null : json["country_block"],
        externalUrl: json["external_url"],
        externalUrlLinkshimmed: json["external_url_linkshimmed"],
        edgeFollowedBy: json["edge_followed_by"] == null
            ? null
            : EdgeFollowClass.fromJson(json["edge_followed_by"]),
        fbid: json["fbid"] == null ? null : json["fbid"],
        followedByViewer: json["followed_by_viewer"] == null
            ? null
            : json["followed_by_viewer"],
        edgeFollow: json["edge_follow"] == null
            ? null
            : EdgeFollowClass.fromJson(json["edge_follow"]),
        followsViewer:
            json["follows_viewer"] == null ? null : json["follows_viewer"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        groupMetadata: json["group_metadata"],
        hasArEffects:
            json["has_ar_effects"] == null ? null : json["has_ar_effects"],
        hasClips: json["has_clips"] == null ? null : json["has_clips"],
        hasGuides: json["has_guides"] == null ? null : json["has_guides"],
        hasChannel: json["has_channel"] == null ? null : json["has_channel"],
        hasBlockedViewer: json["has_blocked_viewer"] == null
            ? null
            : json["has_blocked_viewer"],
        highlightReelCount: json["highlight_reel_count"] == null
            ? null
            : json["highlight_reel_count"],
        hasRequestedViewer: json["has_requested_viewer"] == null
            ? null
            : json["has_requested_viewer"],
        hideLikeAndViewCounts: json["hide_like_and_view_counts"] == null
            ? null
            : json["hide_like_and_view_counts"],
        id: json["id"] == null ? null : json["id"],
        isBusinessAccount: json["is_business_account"] == null
            ? null
            : json["is_business_account"],
        isEligibleToViewAccountTransparency:
            json["is_eligible_to_view_account_transparency"] == null
                ? null
                : json["is_eligible_to_view_account_transparency"],
        isProfessionalAccount: json["is_professional_account"] == null
            ? null
            : json["is_professional_account"],
        isSupervisionEnabled: json["is_supervision_enabled"] == null
            ? null
            : json["is_supervision_enabled"],
        isGuardianOfViewer: json["is_guardian_of_viewer"] == null
            ? null
            : json["is_guardian_of_viewer"],
        isSupervisedByViewer: json["is_supervised_by_viewer"] == null
            ? null
            : json["is_supervised_by_viewer"],
        isSupervisedUser: json["is_supervised_user"] == null
            ? null
            : json["is_supervised_user"],
        isEmbedsDisabled: json["is_embeds_disabled"] == null
            ? null
            : json["is_embeds_disabled"],
        isJoinedRecently: json["is_joined_recently"] == null
            ? null
            : json["is_joined_recently"],
        guardianId: json["guardian_id"],
        businessAddressJson: json["business_address_json"],
        businessContactMethod: json["business_contact_method"] == null
            ? null
            : json["business_contact_method"],
        businessEmail: json["business_email"],
        businessPhoneNumber: json["business_phone_number"],
        businessCategoryName: json["business_category_name"],
        overallCategoryName: json["overall_category_name"],
        categoryEnum: json["category_enum"],
        categoryName: json["category_name"],
        isPrivate: json["is_private"] == null ? null : json["is_private"],
        isVerified: json["is_verified"] == null ? null : json["is_verified"],
        edgeMutualFollowedBy: json["edge_mutual_followed_by"] == null
            ? null
            : EdgeMutualFollowedBy.fromJson(json["edge_mutual_followed_by"]),
        profilePicUrl:
            json["profile_pic_url"] == null ? null : json["profile_pic_url"],
        profilePicUrlHd: json["profile_pic_url_hd"] == null
            ? null
            : json["profile_pic_url_hd"],
        requestedByViewer: json["requested_by_viewer"] == null
            ? null
            : json["requested_by_viewer"],
        shouldShowCategory: json["should_show_category"] == null
            ? null
            : json["should_show_category"],
        shouldShowPublicContacts: json["should_show_public_contacts"] == null
            ? null
            : json["should_show_public_contacts"],
        stateControlledMediaCountry: json["state_controlled_media_country"],
        locationTransparencyCountry: json["location_transparency_country"],
        transparencyLabel: json["transparency_label"],
        transparencyProduct: json["transparency_product"] == null
            ? null
            : json["transparency_product"],
        username: json["username"] == null ? null : json["username"],
        connectedFbPage: json["connected_fb_page"],
        pronouns: json["pronouns"] == null
            ? null
            : List<dynamic>.from(json["pronouns"].map((x) => x)),
        edgeFelixCombinedPostUploads:
            json["edge_felix_combined_post_uploads"] == null
                ? null
                : EdgeFelixCombinedDraftUploadsClass.fromJson(
                    json["edge_felix_combined_post_uploads"]),
        edgeFelixCombinedDraftUploads:
            json["edge_felix_combined_draft_uploads"] == null
                ? null
                : EdgeFelixCombinedDraftUploadsClass.fromJson(
                    json["edge_felix_combined_draft_uploads"]),
        edgeFelixVideoTimeline: json["edge_felix_video_timeline"] == null
            ? null
            : EdgeFelixCombinedDraftUploadsClass.fromJson(
                json["edge_felix_video_timeline"]),
        edgeFelixDrafts: json["edge_felix_drafts"] == null
            ? null
            : EdgeFelixCombinedDraftUploadsClass.fromJson(
                json["edge_felix_drafts"]),
        edgeFelixPendingPostUploads:
            json["edge_felix_pending_post_uploads"] == null
                ? null
                : EdgeFelixCombinedDraftUploadsClass.fromJson(
                    json["edge_felix_pending_post_uploads"]),
        edgeFelixPendingDraftUploads:
            json["edge_felix_pending_draft_uploads"] == null
                ? null
                : EdgeFelixCombinedDraftUploadsClass.fromJson(
                    json["edge_felix_pending_draft_uploads"]),
        edgeOwnerToTimelineMedia: json["edge_owner_to_timeline_media"] == null
            ? null
            : EdgeFelixCombinedDraftUploadsClass.fromJson(
                json["edge_owner_to_timeline_media"]),
        edgeSavedMedia: json["edge_saved_media"] == null
            ? null
            : EdgeFelixCombinedDraftUploadsClass.fromJson(
                json["edge_saved_media"]),
        edgeMediaCollections: json["edge_media_collections"] == null
            ? null
            : EdgeFelixCombinedDraftUploadsClass.fromJson(
                json["edge_media_collections"]),
      );

  Map<String, dynamic> toJson() => {
        "biography": biography == null ? null : biography,
        "bio_links": bioLinks == null
            ? null
            : List<dynamic>.from(bioLinks!.map((x) => x)),
        "biography_with_entities": biographyWithEntities == null
            ? null
            : biographyWithEntities!.toJson(),
        "blocked_by_viewer": blockedByViewer == null ? null : blockedByViewer,
        "restricted_by_viewer":
            restrictedByViewer == null ? null : restrictedByViewer,
        "country_block": countryBlock == null ? null : countryBlock,
        "external_url": externalUrl,
        "external_url_linkshimmed": externalUrlLinkshimmed,
        "edge_followed_by":
            edgeFollowedBy == null ? null : edgeFollowedBy!.toJson(),
        "fbid": fbid == null ? null : fbid,
        "followed_by_viewer":
            followedByViewer == null ? null : followedByViewer,
        "edge_follow": edgeFollow == null ? null : edgeFollow!.toJson(),
        "follows_viewer": followsViewer == null ? null : followsViewer,
        "full_name": fullName == null ? null : fullName,
        "group_metadata": groupMetadata,
        "has_ar_effects": hasArEffects == null ? null : hasArEffects,
        "has_clips": hasClips == null ? null : hasClips,
        "has_guides": hasGuides == null ? null : hasGuides,
        "has_channel": hasChannel == null ? null : hasChannel,
        "has_blocked_viewer":
            hasBlockedViewer == null ? null : hasBlockedViewer,
        "highlight_reel_count":
            highlightReelCount == null ? null : highlightReelCount,
        "has_requested_viewer":
            hasRequestedViewer == null ? null : hasRequestedViewer,
        "hide_like_and_view_counts":
            hideLikeAndViewCounts == null ? null : hideLikeAndViewCounts,
        "id": id == null ? null : id,
        "is_business_account":
            isBusinessAccount == null ? null : isBusinessAccount,
        "is_eligible_to_view_account_transparency":
            isEligibleToViewAccountTransparency == null
                ? null
                : isEligibleToViewAccountTransparency,
        "is_professional_account":
            isProfessionalAccount == null ? null : isProfessionalAccount,
        "is_supervision_enabled":
            isSupervisionEnabled == null ? null : isSupervisionEnabled,
        "is_guardian_of_viewer":
            isGuardianOfViewer == null ? null : isGuardianOfViewer,
        "is_supervised_by_viewer":
            isSupervisedByViewer == null ? null : isSupervisedByViewer,
        "is_supervised_user":
            isSupervisedUser == null ? null : isSupervisedUser,
        "is_embeds_disabled":
            isEmbedsDisabled == null ? null : isEmbedsDisabled,
        "is_joined_recently":
            isJoinedRecently == null ? null : isJoinedRecently,
        "guardian_id": guardianId,
        "business_address_json": businessAddressJson,
        "business_contact_method":
            businessContactMethod == null ? null : businessContactMethod,
        "business_email": businessEmail,
        "business_phone_number": businessPhoneNumber,
        "business_category_name": businessCategoryName,
        "overall_category_name": overallCategoryName,
        "category_enum": categoryEnum,
        "category_name": categoryName,
        "is_private": isPrivate == null ? null : isPrivate,
        "is_verified": isVerified == null ? null : isVerified,
        "edge_mutual_followed_by": edgeMutualFollowedBy == null
            ? null
            : edgeMutualFollowedBy!.toJson(),
        "profile_pic_url": profilePicUrl == null ? null : profilePicUrl,
        "profile_pic_url_hd": profilePicUrlHd == null ? null : profilePicUrlHd,
        "requested_by_viewer":
            requestedByViewer == null ? null : requestedByViewer,
        "should_show_category":
            shouldShowCategory == null ? null : shouldShowCategory,
        "should_show_public_contacts":
            shouldShowPublicContacts == null ? null : shouldShowPublicContacts,
        "state_controlled_media_country": stateControlledMediaCountry,
        "location_transparency_country": locationTransparencyCountry,
        "transparency_label": transparencyLabel,
        "transparency_product":
            transparencyProduct == null ? null : transparencyProduct,
        "username": username == null ? null : username,
        "connected_fb_page": connectedFbPage,
        "pronouns": pronouns == null
            ? null
            : List<dynamic>.from(pronouns!.map((x) => x)),
        "edge_felix_combined_post_uploads": edgeFelixCombinedPostUploads == null
            ? null
            : edgeFelixCombinedPostUploads!.toJson(),
        "edge_felix_combined_draft_uploads":
            edgeFelixCombinedDraftUploads == null
                ? null
                : edgeFelixCombinedDraftUploads!.toJson(),
        "edge_felix_video_timeline": edgeFelixVideoTimeline == null
            ? null
            : edgeFelixVideoTimeline!.toJson(),
        "edge_felix_drafts":
            edgeFelixDrafts == null ? null : edgeFelixDrafts!.toJson(),
        "edge_felix_pending_post_uploads": edgeFelixPendingPostUploads == null
            ? null
            : edgeFelixPendingPostUploads!.toJson(),
        "edge_felix_pending_draft_uploads": edgeFelixPendingDraftUploads == null
            ? null
            : edgeFelixPendingDraftUploads!.toJson(),
        "edge_owner_to_timeline_media": edgeOwnerToTimelineMedia == null
            ? null
            : edgeOwnerToTimelineMedia!.toJson(),
        "edge_saved_media":
            edgeSavedMedia == null ? null : edgeSavedMedia!.toJson(),
        "edge_media_collections": edgeMediaCollections == null
            ? null
            : edgeMediaCollections!.toJson(),
      };
}

class BiographyWithEntities {
  BiographyWithEntities({
    required this.rawText,
    required this.entities,
  });

  final String? rawText;
  final List<dynamic> entities;

  factory BiographyWithEntities.fromJson(Map<String, dynamic> json) =>
      BiographyWithEntities(
        rawText: json["raw_text"] == null ? null : json["raw_text"],
        entities: json["entities"] == null
            ? []
            : List<dynamic>.from(json["entities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "raw_text": rawText == null ? null : rawText,
        "entities": entities == null
            ? null
            : List<dynamic>.from(entities.map((x) => x)),
      };
}

class EdgeFelixCombinedDraftUploadsClass {
  EdgeFelixCombinedDraftUploadsClass({
    required this.count,
    required this.pageInfo,
    required this.edges,
  });

  final int? count;
  final PageInfo? pageInfo;
  final List<Edge>? edges;

  factory EdgeFelixCombinedDraftUploadsClass.fromJson(
          Map<String, dynamic> json) =>
      EdgeFelixCombinedDraftUploadsClass(
        count: json["count"] == null ? null : json["count"],
        pageInfo: json["page_info"] == null
            ? null
            : PageInfo.fromJson(json["page_info"]),
        edges: json["edges"] == null
            ? null
            : List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "page_info": pageInfo == null ? null : pageInfo!.toJson(),
        "edges": edges == null
            ? null
            : List<dynamic>.from(edges!.map((x) => x.toJson())),
      };
}

class Edge {
  Edge({
    required this.node,
  });

  final NodeItem? node;

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: json["node"] == null ? null : NodeItem.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node == null ? null : node!.toJson(),
      };
}

class NodeItem {
  NodeItem({
    required this.typename,
    required this.id,
    required this.shortcode,
    required this.dimensions,
    required this.displayUrl,
    required this.edgeMediaToTaggedUser,
    required this.factCheckOverallRating,
    required this.factCheckInformation,
    required this.gatingInfo,
    required this.sharingFrictionInfo,
    required this.mediaOverlayInfo,
    required this.mediaPreview,
    required this.owner,
    required this.isVideo,
    required this.hasUpcomingEvent,
    required this.accessibilityCaption,
    required this.edgeMediaToCaption,
    required this.edgeMediaToComment,
    required this.commentsDisabled,
    required this.takenAtTimestamp,
    required this.edgeLikedBy,
    required this.edgeMediaPreviewLike,
    required this.location,
    required this.nftAssetInfo,
    required this.thumbnailSrc,
    required this.thumbnailResources,
    required this.coauthorProducers,
    required this.pinnedForUsers,
    required this.videoUrl,
  });

  final String? typename;
  final String? id;
  final String? shortcode;
  final Dimensions? dimensions;
  final String? displayUrl;
  final EdgeMediaTo? edgeMediaToTaggedUser;
  final dynamic factCheckOverallRating;
  final dynamic factCheckInformation;
  final dynamic gatingInfo;
  final SharingFrictionInfo? sharingFrictionInfo;
  final dynamic mediaOverlayInfo;
  final String? mediaPreview;
  final Owner? owner;
  final bool? isVideo;
  final bool? hasUpcomingEvent;
  final String? accessibilityCaption;
  final String? videoUrl;
  final EdgeMediaTo? edgeMediaToCaption;
  final EdgeFollowClass? edgeMediaToComment;
  final bool? commentsDisabled;
  final int? takenAtTimestamp;
  final EdgeFollowClass? edgeLikedBy;
  final EdgeFollowClass? edgeMediaPreviewLike;
  final dynamic location;
  final dynamic nftAssetInfo;
  final String? thumbnailSrc;
  final List<ThumbnailResource>? thumbnailResources;
  final List<dynamic>? coauthorProducers;
  final List<dynamic>? pinnedForUsers;

  factory NodeItem.fromJson(Map<String, dynamic> json) => NodeItem(
        typename: json["__typename"] == null ? null : json["__typename"],
        id: json["id"] == null ? null : json["id"],
        shortcode: json["shortcode"] == null ? null : json["shortcode"],
        dimensions: json["dimensions"] == null
            ? null
            : Dimensions.fromJson(json["dimensions"]),
        displayUrl: json["display_url"] == null ? null : json["display_url"],
        videoUrl: json["video_url"] == null ? null : json["video_url"],
        edgeMediaToTaggedUser: json["edge_media_to_tagged_user"] == null
            ? null
            : EdgeMediaTo.fromJson(json["edge_media_to_tagged_user"]),
        factCheckOverallRating: json["fact_check_overall_rating"],
        factCheckInformation: json["fact_check_information"],
        gatingInfo: json["gating_info"],
        sharingFrictionInfo: json["sharing_friction_info"] == null
            ? null
            : SharingFrictionInfo.fromJson(json["sharing_friction_info"]),
        mediaOverlayInfo: json["media_overlay_info"],
        mediaPreview:
            json["media_preview"] == null ? null : json["media_preview"],
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        isVideo: json["is_video"] == null ? null : json["is_video"],
        hasUpcomingEvent: json["has_upcoming_event"] == null
            ? null
            : json["has_upcoming_event"],
        accessibilityCaption: json["accessibility_caption"] == null
            ? null
            : json["accessibility_caption"],
        edgeMediaToCaption: json["edge_media_to_caption"] == null
            ? null
            : EdgeMediaTo.fromJson(json["edge_media_to_caption"]),
        edgeMediaToComment: json["edge_media_to_comment"] == null
            ? null
            : EdgeFollowClass.fromJson(json["edge_media_to_comment"]),
        commentsDisabled: json["comments_disabled"] == null
            ? null
            : json["comments_disabled"],
        takenAtTimestamp: json["taken_at_timestamp"] == null
            ? null
            : json["taken_at_timestamp"],
        edgeLikedBy: json["edge_liked_by"] == null
            ? null
            : EdgeFollowClass.fromJson(json["edge_liked_by"]),
        edgeMediaPreviewLike: json["edge_media_preview_like"] == null
            ? null
            : EdgeFollowClass.fromJson(json["edge_media_preview_like"]),
        location: json["location"],
        nftAssetInfo: json["nft_asset_info"],
        thumbnailSrc:
            json["thumbnail_src"] == null ? null : json["thumbnail_src"],
        thumbnailResources: json["thumbnail_resources"] == null
            ? null
            : List<ThumbnailResource>.from(json["thumbnail_resources"]
                .map((x) => ThumbnailResource.fromJson(x))),
        coauthorProducers: json["coauthor_producers"] == null
            ? null
            : List<dynamic>.from(json["coauthor_producers"].map((x) => x)),
        pinnedForUsers: json["pinned_for_users"] == null
            ? null
            : List<dynamic>.from(json["pinned_for_users"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename == null ? null : typename,
        "id": id == null ? null : id,
        "shortcode": shortcode == null ? null : shortcode,
        "dimensions": dimensions == null ? null : dimensions!.toJson(),
        "display_url": displayUrl == null ? null : displayUrl,
        "edge_media_to_tagged_user": edgeMediaToTaggedUser == null
            ? null
            : edgeMediaToTaggedUser!.toJson(),
        "fact_check_overall_rating": factCheckOverallRating,
        "fact_check_information": factCheckInformation,
        "gating_info": gatingInfo,
        "sharing_friction_info":
            sharingFrictionInfo == null ? null : sharingFrictionInfo!.toJson(),
        "media_overlay_info": mediaOverlayInfo,
        "media_preview": mediaPreview == null ? null : mediaPreview,
        "owner": owner == null ? null : owner!.toJson(),
        "is_video": isVideo == null ? null : isVideo,
        "has_upcoming_event":
            hasUpcomingEvent == null ? null : hasUpcomingEvent,
        "accessibility_caption":
            accessibilityCaption == null ? null : accessibilityCaption,
        "edge_media_to_caption":
            edgeMediaToCaption == null ? null : edgeMediaToCaption!.toJson(),
        "edge_media_to_comment":
            edgeMediaToComment == null ? null : edgeMediaToComment!.toJson(),
        "comments_disabled": commentsDisabled == null ? null : commentsDisabled,
        "taken_at_timestamp":
            takenAtTimestamp == null ? null : takenAtTimestamp,
        "edge_liked_by": edgeLikedBy == null ? null : edgeLikedBy!.toJson(),
        "edge_media_preview_like": edgeMediaPreviewLike == null
            ? null
            : edgeMediaPreviewLike!.toJson(),
        "location": location,
        "nft_asset_info": nftAssetInfo,
        "thumbnail_src": thumbnailSrc == null ? null : thumbnailSrc,
        "thumbnail_resources": thumbnailResources == null
            ? null
            : List<dynamic>.from(thumbnailResources!.map((x) => x.toJson())),
        "coauthor_producers": coauthorProducers == null
            ? null
            : List<dynamic>.from(coauthorProducers!.map((x) => x)),
        "pinned_for_users": pinnedForUsers == null
            ? null
            : List<dynamic>.from(pinnedForUsers!.map((x) => x)),
      };
}

class Dimensions {
  Dimensions({
    required this.height,
    required this.width,
  });

  final int height;
  final int width;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        height: json["height"] == null ? null : json["height"],
        width: json["width"] == null ? null : json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height == null ? null : height,
        "width": width == null ? null : width,
      };
}

class EdgeFollowClass {
  EdgeFollowClass({
    required this.count,
  });

  final int? count;

  factory EdgeFollowClass.fromJson(Map<String, dynamic> json) =>
      EdgeFollowClass(
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
      };
}

class EdgeMediaTo {
  EdgeMediaTo({
    required this.edges,
  });

  final List<dynamic>? edges;

  factory EdgeMediaTo.fromJson(Map<String, dynamic> json) => EdgeMediaTo(
        edges: json["edges"] == null
            ? null
            : List<dynamic>.from(json["edges"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "edges":
            edges == null ? null : List<dynamic>.from(edges!.map((x) => x)),
      };
}

class Owner {
  Owner({
    required this.id,
    required this.username,
  });

  final String? id;
  final String? username;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
      };
}

class SharingFrictionInfo {
  SharingFrictionInfo({
    required this.shouldHaveSharingFriction,
    required this.bloksAppUrl,
  });

  final bool shouldHaveSharingFriction;
  final dynamic bloksAppUrl;

  factory SharingFrictionInfo.fromJson(Map<String, dynamic> json) =>
      SharingFrictionInfo(
        shouldHaveSharingFriction: json["should_have_sharing_friction"] == null
            ? null
            : json["should_have_sharing_friction"],
        bloksAppUrl: json["bloks_app_url"],
      );

  Map<String, dynamic> toJson() => {
        "should_have_sharing_friction": shouldHaveSharingFriction == null
            ? null
            : shouldHaveSharingFriction,
        "bloks_app_url": bloksAppUrl,
      };
}

class ThumbnailResource {
  ThumbnailResource({
    required this.src,
    required this.configWidth,
    required this.configHeight,
  });

  final String? src;
  final int configWidth;
  final int configHeight;

  factory ThumbnailResource.fromJson(Map<String, dynamic> json) =>
      ThumbnailResource(
        src: json["src"] == null ? null : json["src"],
        configWidth: json["config_width"] == null ? null : json["config_width"],
        configHeight:
            json["config_height"] == null ? null : json["config_height"],
      );

  Map<String, dynamic> toJson() => {
        "src": src == null ? null : src,
        "config_width": configWidth == null ? null : configWidth,
        "config_height": configHeight == null ? null : configHeight,
      };
}

class PageInfo {
  PageInfo({
    required this.hasNextPage,
    required this.endCursor,
  });

  final bool hasNextPage;
  final String? endCursor;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        hasNextPage:
            json["has_next_page"] == null ? null : json["has_next_page"],
        endCursor: json["end_cursor"] == null ? null : json["end_cursor"],
      );

  Map<String, dynamic> toJson() => {
        "has_next_page": hasNextPage == null ? null : hasNextPage,
        "end_cursor": endCursor == null ? null : endCursor,
      };
}

class EdgeMutualFollowedBy {
  EdgeMutualFollowedBy({
    required this.count,
    required this.edges,
  });

  final int? count;
  final List<dynamic>? edges;

  factory EdgeMutualFollowedBy.fromJson(Map<String, dynamic> json) =>
      EdgeMutualFollowedBy(
        count: json["count"] == null ? null : json["count"],
        edges: json["edges"] == null
            ? null
            : List<dynamic>.from(json["edges"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "edges":
            edges == null ? null : List<dynamic>.from(edges!.map((x) => x)),
      };
}
