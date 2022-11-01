// To parse this JSON data, do
//
//     final messages = messagesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import '../ui/search/SearchUser.dart';

Messages messagesFromJson(String str) => Messages.fromJson(json.decode(str));

class Messages {
  Messages({
    required this.viewer,
    required this.inbox,
    required this.seqId,
    required this.pendingRequestsTotal,
    required this.hasPendingTopRequests,
    required this.status,
  });

  final Viewer? viewer;
  final Inbox? inbox;
  final dynamic seqId;
  final dynamic pendingRequestsTotal;
  final bool? hasPendingTopRequests;
  final dynamic status;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        viewer: json["viewer"] == null ? null : Viewer.fromJson(json["viewer"]),
        inbox: json["inbox"] == null ? null : Inbox.fromJson(json["inbox"]),
        seqId: json["seq_id"] == null ? null : json["seq_id"],
        pendingRequestsTotal: json["pending_requests_total"] == null
            ? null
            : json["pending_requests_total"],
        hasPendingTopRequests: json["has_pending_top_requests"] == null
            ? null
            : json["has_pending_top_requests"],
        status: json["status"] == null ? null : json["status"],
      );
}

class Inbox {
  Inbox({
    required this.threads,
    required this.hasOlder,
    required this.unseenCount,
    required this.unseenCountTs,
    required this.prevCursor,
    required this.nextCursor,
    required this.blendedInboxEnabled,
  });

  final List<Thread>? threads;
  final bool? hasOlder;
  final dynamic unseenCount;
  final dynamic unseenCountTs;
  final PrevCursor? prevCursor;
  final NextCursor? nextCursor;
  final bool? blendedInboxEnabled;

  factory Inbox.fromJson(Map<String, dynamic> json) => Inbox(
        threads: json["threads"] == null
            ? null
            : List<Thread>.from(json["threads"].map((x) => Thread.fromJson(x))),
        hasOlder: json["has_older"] == null ? null : json["has_older"],
        unseenCount: json["unseen_count"] == null ? null : json["unseen_count"],
        unseenCountTs:
            json["unseen_count_ts"] == null ? null : json["unseen_count_ts"],
        prevCursor: json["prev_cursor"] == null
            ? null
            : PrevCursor.fromJson(json["prev_cursor"]),
        nextCursor: json["next_cursor"] == null
            ? null
            : NextCursor.fromJson(json["next_cursor"]),
        blendedInboxEnabled: json["blended_inbox_enabled"] == null
            ? null
            : json["blended_inbox_enabled"],
      );
}

class NextCursor {
  NextCursor({
    required this.cursorTimestampSeconds,
    required this.cursorRelevancyScore,
    required this.cursorThreadV2Id,
  });

  final dynamic cursorTimestampSeconds;
  final dynamic cursorRelevancyScore;
  final dynamic cursorThreadV2Id;

  factory NextCursor.fromJson(Map<String, dynamic> json) => NextCursor(
        cursorTimestampSeconds: json["cursor_timestamp_seconds"] == null
            ? null
            : json["cursor_timestamp_seconds"],
        cursorRelevancyScore: json["cursor_relevancy_score"] == null
            ? null
            : json["cursor_relevancy_score"],
        cursorThreadV2Id: json["cursor_thread_v2_id"] == null
            ? null
            : json["cursor_thread_v2_id"],
      );

  Map<String, dynamic> toJson() => {
        "cursor_timestamp_seconds":
            cursorTimestampSeconds == null ? null : cursorTimestampSeconds,
        "cursor_relevancy_score":
            cursorRelevancyScore == null ? null : cursorRelevancyScore,
        "cursor_thread_v2_id":
            cursorThreadV2Id == null ? null : cursorThreadV2Id,
      };
}

class PrevCursor {
  PrevCursor({
    required this.cursorTimestampSeconds,
    required this.cursorRelevancyScore,
    required this.cursorThreadV2Id,
  });

  final dynamic cursorTimestampSeconds;
  final dynamic cursorRelevancyScore;
  final dynamic cursorThreadV2Id;

  factory PrevCursor.fromJson(Map<String, dynamic> json) => PrevCursor(
        cursorTimestampSeconds: json["cursor_timestamp_seconds"] == null
            ? null
            : json["cursor_timestamp_seconds"],
        cursorRelevancyScore: json["cursor_relevancy_score"] == null
            ? null
            : json["cursor_relevancy_score"],
        cursorThreadV2Id: json["cursor_thread_v2_id"] == null
            ? null
            : json["cursor_thread_v2_id"],
      );

  Map<String, dynamic> toJson() => {
        "cursor_timestamp_seconds":
            cursorTimestampSeconds == null ? null : cursorTimestampSeconds,
        "cursor_relevancy_score":
            cursorRelevancyScore == null ? null : cursorRelevancyScore,
        "cursor_thread_v2_id":
            cursorThreadV2Id == null ? null : cursorThreadV2Id,
      };
}

class Thread {
  Thread({
    required this.hasOlder,
    required this.hasNewer,
    required this.pending,
    required this.items,
    required this.canonical,
    required this.threadId,
    required this.threadV2Id,
    required this.users,
    required this.viewerId,
    required this.lastActivityAt,
    required this.muted,
    required this.vcMuted,
    required this.encodedServerDataInfo,
    required this.adminUserIds,
    required this.approvalRequiredForNewMembers,
    required this.archived,
    required this.threadHasAudioOnlyCall,
    required this.pendingUserIds,
    required this.lastSeenAt,
    required this.relevancyScore,
    required this.relevancyScoreExpr,
    required this.oldestCursor,
    required this.newestCursor,
    required this.inviter,
    required this.labelItems,
    required this.lastPermanentItem,
    required this.named,
    required this.nextCursor,
    required this.prevCursor,
    required this.threadTitle,
    required this.leftUsers,
    required this.spam,
    required this.bcPartnership,
    required this.mentionsMuted,
    required this.threadType,
    required this.threadSubtype,
    required this.chatActivityMuted,
    required this.outgoingChatActivityMuted,
    required this.outgoingReelsTogetherActivityMuted,
    required this.threadHasDropIn,
    required this.videoCallId,
    required this.shhModeEnabled,
    required this.shhTogglerUserid,
    required this.shhReplayEnabled,
    required this.isGroup,
    required this.inputMode,
    required this.readState,
    required this.assignedAdminId,
    required this.folder,
    required this.lastNonSenderItemAt,
    required this.businessThreadFolder,
    required this.theme,
    required this.themeData,
    required this.threadLabel,
    required this.markedAsUnread,
    required this.threadContextItems,
    required this.isCloseFriendThread,
    required this.hasGroupsXacIneligibleUser,
    required this.threadImage,
    required this.isXacThread,
    required this.isTranslationEnabled,
    required this.translationBannerImpressionCount,
    required this.systemFolder,
    required this.isFanclubSubscriberThread,
    required this.joinableGroupLink,
    required this.groupLinkJoinableMode,
    required this.smartSuggestion,
    required this.isCreatorSubscriberThread,
    required this.creatorSubscriberThreadResponse,
    required this.inboxNudgeDismissedMs,
    required this.lastMessageTimestampMs,
    required this.rtcFeatureSetStr,
    required this.persistentMenuIcebreakers,
    required this.hasReachedMessageRequestLimit,
    required this.responsivenessCategory,
    required this.publicChatMetadata,
    required this.boardsCallData,
    required this.igThreadCapabilities,
    required this.dismissInboxNudge,
    required this.snippet,
  });

  final bool? hasOlder;
  final bool? hasNewer;
  final bool? pending;
  final List<Item>? items;
  final bool? canonical;
  final dynamic threadId;
  final dynamic threadV2Id;
  final List<Viewer>? users;
  final dynamic viewerId;
  final dynamic lastActivityAt;
  final bool? muted;
  final bool? vcMuted;
  final dynamic encodedServerDataInfo;
  final List<dynamic>? adminUserIds;
  final bool? approvalRequiredForNewMembers;
  final bool? archived;
  final bool? threadHasAudioOnlyCall;
  final List<dynamic>? pendingUserIds;
  final Map<String, LastSeenAt>? lastSeenAt;
  final dynamic relevancyScore;
  final dynamic relevancyScoreExpr;
  final dynamic oldestCursor;
  final dynamic newestCursor;
  final Inviter? inviter;
  final List<dynamic>? labelItems;
  final Item? lastPermanentItem;
  final bool? named;
  final dynamic nextCursor;
  final dynamic prevCursor;
  final dynamic threadTitle;
  final List<dynamic>? leftUsers;
  final bool? spam;
  final bool? bcPartnership;
  final bool? mentionsMuted;
  final dynamic threadType;
  final dynamic threadSubtype;
  final bool? chatActivityMuted;
  final bool? outgoingChatActivityMuted;
  final bool? outgoingReelsTogetherActivityMuted;
  final bool? threadHasDropIn;
  final dynamic videoCallId;
  final bool? shhModeEnabled;
  final dynamic shhTogglerUserid;
  final bool? shhReplayEnabled;
  final bool? isGroup;
  final dynamic inputMode;
  final dynamic readState;
  final dynamic assignedAdminId;
  final dynamic folder;
  final dynamic lastNonSenderItemAt;
  final dynamic businessThreadFolder;
  final Theme? theme;
  final dynamic themeData;
  final dynamic threadLabel;
  final bool? markedAsUnread;
  final List<ThreadContextItem>? threadContextItems;
  final bool? isCloseFriendThread;
  final bool? hasGroupsXacIneligibleUser;
  final dynamic threadImage;
  final bool? isXacThread;
  final bool? isTranslationEnabled;
  final dynamic translationBannerImpressionCount;
  final dynamic systemFolder;
  final bool? isFanclubSubscriberThread;
  final dynamic joinableGroupLink;
  final dynamic groupLinkJoinableMode;
  final dynamic smartSuggestion;
  final bool? isCreatorSubscriberThread;
  final dynamic creatorSubscriberThreadResponse;
  final dynamic inboxNudgeDismissedMs;
  final dynamic lastMessageTimestampMs;
  final dynamic rtcFeatureSetStr;
  final PersistentMenuIcebreakers? persistentMenuIcebreakers;
  final dynamic hasReachedMessageRequestLimit;
  final dynamic responsivenessCategory;
  final PublicChatMetadata? publicChatMetadata;
  final dynamic boardsCallData;
  final IgThreadCapabilities? igThreadCapabilities;
  final dynamic dismissInboxNudge;
  final dynamic snippet;

  factory Thread.fromJson(Map<String, dynamic> json) => Thread(
        hasOlder: json["has_older"] == null ? null : json["has_older"],
        hasNewer: json["has_newer"] == null ? null : json["has_newer"],
        pending: json["pending"] == null ? null : json["pending"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        canonical: json["canonical"] == null ? null : json["canonical"],
        threadId: json["thread_id"] == null ? null : json["thread_id"],
        threadV2Id: json["thread_v2_id"] == null ? null : json["thread_v2_id"],
        users: json["users"] == null
            ? null
            : List<Viewer>.from(json["users"].map((x) => Viewer.fromJson(x))),
        viewerId: json["viewer_id"] == null ? null : json["viewer_id"],
        lastActivityAt:
            json["last_activity_at"] == null ? null : json["last_activity_at"],
        muted: json["muted"] == null ? null : json["muted"],
        vcMuted: json["vc_muted"] == null ? null : json["vc_muted"],
        encodedServerDataInfo: json["encoded_server_data_info"] == null
            ? null
            : json["encoded_server_data_info"],
        adminUserIds: json["admin_user_ids"] == null
            ? null
            : List<dynamic>.from(json["admin_user_ids"].map((x) => x)),
        approvalRequiredForNewMembers:
            json["approval_required_for_new_members"] == null
                ? null
                : json["approval_required_for_new_members"],
        archived: json["archived"] == null ? null : json["archived"],
        threadHasAudioOnlyCall: json["thread_has_audio_only_call"] == null
            ? null
            : json["thread_has_audio_only_call"],
        pendingUserIds: json["pending_user_ids"] == null
            ? null
            : List<dynamic>.from(json["pending_user_ids"].map((x) => x)),
        lastSeenAt: json["last_seen_at"] == null
            ? null
            : Map.from(json["last_seen_at"]).map((k, v) =>
                MapEntry<String, LastSeenAt>(k, LastSeenAt.fromJson(v))),
        relevancyScore:
            json["relevancy_score"] == null ? null : json["relevancy_score"],
        relevancyScoreExpr: json["relevancy_score_expr"] == null
            ? null
            : json["relevancy_score_expr"],
        oldestCursor:
            json["oldest_cursor"] == null ? null : json["oldest_cursor"],
        newestCursor:
            json["newest_cursor"] == null ? null : json["newest_cursor"],
        inviter:
            json["inviter"] == null ? null : Inviter.fromJson(json["inviter"]),
        labelItems: json["label_items"] == null
            ? null
            : List<dynamic>.from(json["label_items"].map((x) => x)),
        lastPermanentItem: json["last_permanent_item"] == null
            ? null
            : Item.fromJson(json["last_permanent_item"]),
        named: json["named"] == null ? null : json["named"],
        nextCursor: json["next_cursor"] == null ? null : json["next_cursor"],
        prevCursor: json["prev_cursor"] == null ? null : json["prev_cursor"],
        threadTitle: json["thread_title"] == null ? null : json["thread_title"],
        leftUsers: json["left_users"] == null
            ? null
            : List<dynamic>.from(json["left_users"].map((x) => x)),
        spam: json["spam"] == null ? null : json["spam"],
        bcPartnership:
            json["bc_partnership"] == null ? null : json["bc_partnership"],
        mentionsMuted:
            json["mentions_muted"] == null ? null : json["mentions_muted"],
        threadType: json["thread_type"] == null ? null : json["thread_type"],
        threadSubtype:
            json["thread_subtype"] == null ? null : json["thread_subtype"],
        chatActivityMuted: json["chat_activity_muted"] == null
            ? null
            : json["chat_activity_muted"],
        outgoingChatActivityMuted: json["outgoing_chat_activity_muted"] == null
            ? null
            : json["outgoing_chat_activity_muted"],
        outgoingReelsTogetherActivityMuted:
            json["outgoing_reels_together_activity_muted"] == null
                ? null
                : json["outgoing_reels_together_activity_muted"],
        threadHasDropIn: json["thread_has_drop_in"] == null
            ? null
            : json["thread_has_drop_in"],
        videoCallId: json["video_call_id"],
        shhModeEnabled:
            json["shh_mode_enabled"] == null ? null : json["shh_mode_enabled"],
        shhTogglerUserid: json["shh_toggler_userid"],
        shhReplayEnabled: json["shh_replay_enabled"] == null
            ? null
            : json["shh_replay_enabled"],
        isGroup: json["is_group"] == null ? null : json["is_group"],
        inputMode: json["input_mode"] == null ? null : json["input_mode"],
        readState: json["read_state"] == null ? null : json["read_state"],
        assignedAdminId: json["assigned_admin_id"] == null
            ? null
            : json["assigned_admin_id"],
        folder: json["folder"] == null ? null : json["folder"],
        lastNonSenderItemAt: json["last_non_sender_item_at"] == null
            ? null
            : json["last_non_sender_item_at"],
        businessThreadFolder: json["business_thread_folder"] == null
            ? null
            : json["business_thread_folder"],
        theme: json["theme"] == null ? null : Theme.fromJson(json["theme"]),
        themeData: json["theme_data"],
        threadLabel: json["thread_label"] == null ? null : json["thread_label"],
        markedAsUnread:
            json["marked_as_unread"] == null ? null : json["marked_as_unread"],
        threadContextItems: json["thread_context_items"] == null
            ? null
            : List<ThreadContextItem>.from(json["thread_context_items"]
                .map((x) => ThreadContextItem.fromJson(x))),
        isCloseFriendThread: json["is_close_friend_thread"] == null
            ? null
            : json["is_close_friend_thread"],
        hasGroupsXacIneligibleUser:
            json["has_groups_xac_ineligible_user"] == null
                ? null
                : json["has_groups_xac_ineligible_user"],
        threadImage: json["thread_image"],
        isXacThread:
            json["is_xac_thread"] == null ? null : json["is_xac_thread"],
        isTranslationEnabled: json["is_translation_enabled"] == null
            ? null
            : json["is_translation_enabled"],
        translationBannerImpressionCount:
            json["translation_banner_impression_count"] == null
                ? null
                : json["translation_banner_impression_count"],
        systemFolder:
            json["system_folder"] == null ? null : json["system_folder"],
        isFanclubSubscriberThread: json["is_fanclub_subscriber_thread"] == null
            ? null
            : json["is_fanclub_subscriber_thread"],
        joinableGroupLink: json["joinable_group_link"] == null
            ? null
            : json["joinable_group_link"],
        groupLinkJoinableMode: json["group_link_joinable_mode"] == null
            ? null
            : json["group_link_joinable_mode"],
        smartSuggestion: json["smart_suggestion"],
        isCreatorSubscriberThread: json["is_creator_subscriber_thread"] == null
            ? null
            : json["is_creator_subscriber_thread"],
        creatorSubscriberThreadResponse:
            json["creator_subscriber_thread_response"],
        inboxNudgeDismissedMs: json["inbox_nudge_dismissed_ms"],
        lastMessageTimestampMs: json["last_message_timestamp_ms"],
        rtcFeatureSetStr: json["rtc_feature_set_str"] == null
            ? null
            : json["rtc_feature_set_str"],
        persistentMenuIcebreakers: json["persistent_menu_icebreakers"] == null
            ? null
            : PersistentMenuIcebreakers.fromJson(
                json["persistent_menu_icebreakers"]),
        hasReachedMessageRequestLimit:
            json["has_reached_message_request_limit"],
        responsivenessCategory: json["responsiveness_category"],
        publicChatMetadata: json["public_chat_metadata"] == null
            ? null
            : PublicChatMetadata.fromJson(json["public_chat_metadata"]),
        boardsCallData: json["boards_call_data"],
        igThreadCapabilities: json["ig_thread_capabilities"] == null
            ? null
            : IgThreadCapabilities.fromJson(json["ig_thread_capabilities"]),
        dismissInboxNudge: json["dismiss_inbox_nudge"],
        snippet: json["snippet"],
      );
}

class IgThreadCapabilities {
  IgThreadCapabilities({
    required this.capabilities0,
  });

  final int capabilities0;

  factory IgThreadCapabilities.fromJson(Map<String, dynamic> json) =>
      IgThreadCapabilities(
        capabilities0:
            json["capabilities_0"] == null ? null : json["capabilities_0"],
      );

  Map<String, dynamic> toJson() => {
        "capabilities_0": capabilities0 == null ? null : capabilities0,
      };
}

class Inviter {
  Inviter({
    required this.pk,
    required this.username,
    required this.fullName,
    required this.isPrivate,
    required this.profilePicUrl,
    required this.profilePicId,
    required this.isVerified,
    required this.hasAnonymousProfilePicture,
    required this.reachabilityStatus,
    required this.hasHighlightReels,
    required this.accountBadges,
  });

  final dynamic pk;
  final dynamic username;
  final dynamic fullName;
  final bool? isPrivate;
  final dynamic profilePicUrl;
  final dynamic profilePicId;
  final bool? isVerified;
  final bool? hasAnonymousProfilePicture;
  final dynamic reachabilityStatus;
  final bool? hasHighlightReels;
  final List<dynamic>? accountBadges;

  factory Inviter.fromJson(Map<String, dynamic> json) => Inviter(
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
        reachabilityStatus: json["reachability_status"] == null
            ? null
            : json["reachability_status"],
        hasHighlightReels: json["has_highlight_reels"] == null
            ? null
            : json["has_highlight_reels"],
        accountBadges: json["account_badges"] == null
            ? null
            : List<dynamic>.from(json["account_badges"].map((x) => x)),
      );
}

class Item {
  Item(
      {required this.itemId,
      required this.userId,
      required this.timestamp,
      required this.itemType,
      required this.clientContext,
      required this.showForwardAttribution,
      required this.forwardScore,
      required this.isShhMode,
      required this.isSentByViewer,
      required this.uqSeqId,
      required this.text,
      required this.sendAttribution,
      required this.clip,
      required this.reactions,
      required this.actionlog,
      required this.reelshare,
      required this.link,
      required this.media,
      required this.voice_media,
      required this.media_share,
      required this.videoCallEvent});

  final dynamic itemId;
  final dynamic userId;
  final dynamic timestamp;
  final dynamic itemType;
  final dynamic clientContext;
  final bool? showForwardAttribution;
  final dynamic forwardScore;
  final bool? isShhMode;
  final bool? isSentByViewer;
  final dynamic uqSeqId;
  final dynamic text;
  final dynamic sendAttribution;
  final VideoCallEventClass? videoCallEvent;
  final dynamic clip;
  final dynamic reactions;
  final dynamic actionlog;
  final dynamic reelshare;
  final dynamic link;
  final dynamic media;
  final dynamic voice_media;
  final dynamic media_share;
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["item_id"] == null ? null : json["item_id"],
        voice_media: json["voice_media"] == null ? null : json["voice_media"],
        media: json["media"] == null ? null : json["media"],
        media_share: json["media_share"] == null ? null : json["media_share"],
        actionlog: json["action_log"] == null ? null : json["action_log"],
        link: json["link"] == null ? null : json["link"],
        reelshare: json["reel_share"] == null ? null : json["reel_share"],
        clip: json["clip"] == null ? null : json["clip"],
        userId: json["user_id"] == null ? null : json["user_id"],
        reactions: json["reactions"] == null ? null : json["reactions"],
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
        itemType: json["item_type"] == null ? null : json["item_type"],
        clientContext:
            json["client_context"] == null ? null : json["client_context"],
        showForwardAttribution: json["show_forward_attribution"] == null
            ? null
            : json["show_forward_attribution"],
        forwardScore: json["forward_score"],
        isShhMode: json["is_shh_mode"] == null ? null : json["is_shh_mode"],
        isSentByViewer: json["is_sent_by_viewer"] == null
            ? null
            : json["is_sent_by_viewer"],
        uqSeqId: json["uq_seq_id"] == null ? null : json["uq_seq_id"],
        text: json["text"] == null ? null : json["text"],
        sendAttribution:
            json["send_attribution"] == null ? null : json["send_attribution"],
        videoCallEvent: json["video_call_event"] == null
            ? null
            : VideoCallEventClass.fromJson(json["video_call_event"]),
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId == null ? null : itemId,
        "user_id": userId == null ? null : userId,
        "timestamp": timestamp == null ? null : timestamp,
        "item_type": itemType == null ? null : itemType,
        "client_context": clientContext == null ? null : clientContext,
        "show_forward_attribution":
            showForwardAttribution == null ? null : showForwardAttribution,
        "forward_score": forwardScore,
        "is_shh_mode": isShhMode == null ? null : isShhMode,
        "is_sent_by_viewer": isSentByViewer == null ? null : isSentByViewer,
        "uq_seq_id": uqSeqId == null ? null : uqSeqId,
        "text": text == null ? null : text,
        "send_attribution": sendAttribution == null ? null : sendAttribution,
      };
}
// To parse this JSON data, do
//
//     final videoCallEvent = videoCallEventFromJson(jsonString);

class VideoCallEventClass {
  VideoCallEventClass({
    required this.action,
    required this.vcId,
    required this.encodedServerDataInfo,
    required this.description,
    required this.textAttributes,
    required this.didJoin,
    required this.threadHasAudioOnlyCall,
    required this.threadHasDropIn,
    required this.featureSetStr,
    required this.callDuration,
    required this.callStartTime,
    required this.callEndTime,
  });

  final dynamic action;
  final dynamic vcId;
  final dynamic encodedServerDataInfo;
  final dynamic description;
  final List<TextAttribute>? textAttributes;
  final dynamic didJoin;
  final bool? threadHasAudioOnlyCall;
  final bool? threadHasDropIn;
  final dynamic featureSetStr;
  final dynamic callDuration;
  final dynamic callStartTime;
  final dynamic callEndTime;

  factory VideoCallEventClass.fromJson(Map<String, dynamic> json) =>
      VideoCallEventClass(
        action: json["action"] == null ? null : json["action"],
        vcId: json["vc_id"] == null ? null : json["vc_id"],
        encodedServerDataInfo: json["encoded_server_data_info"] == null
            ? null
            : json["encoded_server_data_info"],
        description: json["description"] == null ? null : json["description"],
        textAttributes: json["text_attributes"] == null
            ? null
            : List<TextAttribute>.from(
                json["text_attributes"].map((x) => TextAttribute.fromJson(x))),
        didJoin: json["did_join"],
        threadHasAudioOnlyCall: json["thread_has_audio_only_call"] == null
            ? null
            : json["thread_has_audio_only_call"],
        threadHasDropIn: json["thread_has_drop_in"] == null
            ? null
            : json["thread_has_drop_in"],
        featureSetStr:
            json["feature_set_str"] == null ? null : json["feature_set_str"],
        callDuration:
            json["call_duration"] == null ? null : json["call_duration"],
        callStartTime:
            json["call_start_time"] == null ? null : json["call_start_time"],
        callEndTime:
            json["call_end_time"] == null ? null : json["call_end_time"],
      );
}

class TextAttribute {
  TextAttribute({
    required this.start,
    required this.end,
    required this.bold,
    required this.color,
    required this.intent,
  });

  final dynamic start;
  final dynamic end;
  final dynamic bold;
  final dynamic color;
  final dynamic intent;

  factory TextAttribute.fromJson(Map<String, dynamic> json) => TextAttribute(
        start: json["start"] == null ? null : json["start"],
        end: json["end"] == null ? null : json["end"],
        bold: json["bold"] == null ? null : json["bold"],
        color: json["color"] == null ? null : json["color"],
        intent: json["intent"] == null ? null : json["intent"],
      );

  Map<String, dynamic> toJson() => {
        "start": start == null ? null : start,
        "end": end == null ? null : end,
        "bold": bold == null ? null : bold,
        "color": color == null ? null : color,
        "intent": intent == null ? null : intent,
      };
}

class LastSeenAt {
  LastSeenAt({
    required this.timestamp,
    required this.itemId,
    required this.shhSeenState,
    required this.createdAt,
  });

  final dynamic timestamp;
  final dynamic itemId;
  final ShhSeenState? shhSeenState;
  final dynamic createdAt;

  factory LastSeenAt.fromJson(Map<String, dynamic> json) => LastSeenAt(
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
        itemId: json["item_id"] == null ? null : json["item_id"],
        shhSeenState: json["shh_seen_state"] == null
            ? null
            : ShhSeenState.fromJson(json["shh_seen_state"]),
        createdAt: json["created_at"] == null ? null : json["created_at"],
      );
}

class ShhSeenState {
  ShhSeenState();

  factory ShhSeenState.fromJson(Map<String, dynamic> json) => ShhSeenState();

  Map<String, dynamic> toJson() => {};
}

class PersistentMenuIcebreakers {
  PersistentMenuIcebreakers({
    required this.persistentIcebreakers,
    required this.areDefaultIcebreakers,
  });

  final List<dynamic>? persistentIcebreakers;
  final bool? areDefaultIcebreakers;

  factory PersistentMenuIcebreakers.fromJson(Map<String, dynamic> json) =>
      PersistentMenuIcebreakers(
        persistentIcebreakers: json["persistent_icebreakers"] == null
            ? null
            : List<dynamic>.from(json["persistent_icebreakers"].map((x) => x)),
        areDefaultIcebreakers: json["are_default_icebreakers"] == null
            ? null
            : json["are_default_icebreakers"],
      );
}

class PublicChatMetadata {
  PublicChatMetadata({
    required this.isPublic,
    required this.isPinnableToViewerProfile,
    required this.isPinnedToViewerProfile,
    required this.isAddedToInbox,
  });

  final bool? isPublic;
  final bool? isPinnableToViewerProfile;
  final bool? isPinnedToViewerProfile;
  final bool? isAddedToInbox;

  factory PublicChatMetadata.fromJson(Map<String, dynamic> json) =>
      PublicChatMetadata(
        isPublic: json["is_public"] == null ? null : json["is_public"],
        isPinnableToViewerProfile: json["is_pinnable_to_viewer_profile"] == null
            ? null
            : json["is_pinnable_to_viewer_profile"],
        isPinnedToViewerProfile: json["is_pinned_to_viewer_profile"] == null
            ? null
            : json["is_pinned_to_viewer_profile"],
        isAddedToInbox: json["is_added_to_inbox"] == null
            ? null
            : json["is_added_to_inbox"],
      );

  Map<String, dynamic> toJson() => {
        "is_public": isPublic == null ? null : isPublic,
        "is_pinnable_to_viewer_profile": isPinnableToViewerProfile == null
            ? null
            : isPinnableToViewerProfile,
        "is_pinned_to_viewer_profile":
            isPinnedToViewerProfile == null ? null : isPinnedToViewerProfile,
        "is_added_to_inbox": isAddedToInbox == null ? null : isAddedToInbox,
      };
}

class Theme {
  Theme({
    required this.id,
  });

  final String id;

  factory Theme.fromJson(Map<String, dynamic> json) => Theme(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
      };
}

class ThreadContextItem {
  ThreadContextItem({
    required this.type,
    required this.text,
  });

  final dynamic type;
  final dynamic text;

  factory ThreadContextItem.fromJson(Map<String, dynamic> json) =>
      ThreadContextItem(
        type: json["type"] == null ? null : json["type"],
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "text": text == null ? null : text,
      };
}

class Viewer {
  Viewer({
    required this.pk,
    required this.username,
    required this.fullName,
    required this.isPrivate,
    required this.profilePicUrl,
    required this.profilePicId,
    required this.friendshipStatus,
    required this.isVerified,
    required this.hasAnonymousProfilePicture,
    required this.isSupervisionFeaturesEnabled,
    required this.hasHighlightReels,
    required this.isUsingUnifiedInboxForDirect,
    required this.bizUserInboxState,
    required this.waAddressable,
    required this.waEligibility,
    required this.interopMessagingUserFbid,
    required this.accountBadges,
    required this.fbidV2,
    required this.reelAutoArchive,
  });

  final dynamic pk;
  final dynamic username;
  final dynamic fullName;
  final bool? isPrivate;
  final dynamic profilePicUrl;
  final dynamic profilePicId;
  final FriendshipStatus? friendshipStatus;
  final bool? isVerified;
  final bool? hasAnonymousProfilePicture;
  final bool? isSupervisionFeaturesEnabled;
  final bool? hasHighlightReels;
  final bool? isUsingUnifiedInboxForDirect;
  final dynamic bizUserInboxState;
  final bool? waAddressable;
  final dynamic waEligibility;
  final dynamic interopMessagingUserFbid;
  final List<dynamic>? accountBadges;
  final dynamic fbidV2;
  final dynamic reelAutoArchive;

  factory Viewer.fromJson(Map<String, dynamic> json) => Viewer(
        pk: json["pk"] == null ? null : json["pk"],
        username: json["username"] == null ? null : json["username"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        isPrivate: json["is_private"] == null ? null : json["is_private"],
        profilePicUrl:
            json["profile_pic_url"] == null ? null : json["profile_pic_url"],
        profilePicId:
            json["profile_pic_id"] == null ? null : json["profile_pic_id"],
        friendshipStatus: json["friendship_status"] == null
            ? null
            : FriendshipStatus.fromJson(json["friendship_status"]),
        isVerified: json["is_verified"] == null ? null : json["is_verified"],
        hasAnonymousProfilePicture:
            json["has_anonymous_profile_picture"] == null
                ? null
                : json["has_anonymous_profile_picture"],
        isSupervisionFeaturesEnabled:
            json["is_supervision_features_enabled"] == null
                ? null
                : json["is_supervision_features_enabled"],
        hasHighlightReels: json["has_highlight_reels"] == null
            ? null
            : json["has_highlight_reels"],
        isUsingUnifiedInboxForDirect:
            json["is_using_unified_inbox_for_direct"] == null
                ? null
                : json["is_using_unified_inbox_for_direct"],
        bizUserInboxState: json["biz_user_inbox_state"] == null
            ? null
            : json["biz_user_inbox_state"],
        waAddressable:
            json["wa_addressable"] == null ? null : json["wa_addressable"],
        waEligibility:
            json["wa_eligibility"] == null ? null : json["wa_eligibility"],
        interopMessagingUserFbid: json["interop_messaging_user_fbid"] == null
            ? null
            : json["interop_messaging_user_fbid"],
        accountBadges: json["account_badges"] == null
            ? null
            : List<dynamic>.from(json["account_badges"].map((x) => x)),
        fbidV2: json["fbid_v2"] == null ? null : json["fbid_v2"],
        reelAutoArchive: json["reel_auto_archive"] == null
            ? null
            : json["reel_auto_archive"],
      );
}
