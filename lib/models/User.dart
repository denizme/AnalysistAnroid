// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  User({
    required this.user,
    required this.status,
  });

  final UserClass user;
  final String status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: UserClass.fromJson(json["user"]),
        status: json["status"] == null ? null : json["status"],
      );
}

class UserClass {
  UserClass({
    required this.pk,
    required this.username,
    required this.fullName,
    required this.isPrivate,
    required this.profilePicUrl,
    required this.isVerified,
    required this.followFrictionType,
    required this.hasAnonymousProfilePicture,
    required this.mediaCount,
    required this.followerCount,
    required this.followingCount,
    required this.followingTagCount,
    required this.isSupervisionFeaturesEnabled,
    required this.biography,
    required this.externalUrl,
    required this.showFbLinkOnProfile,
    required this.primaryProfileLinkType,
    required this.canBoostPost,
    required this.canSeeOrganicInsights,
    required this.showInsightsTerms,
    required this.canConvertToBusiness,
    required this.canCreateSponsorTags,
    required this.isAllowedToCreateStandaloneNonprofitFundraisers,
    required this.isAllowedToCreateStandalonePersonalFundraisers,
    required this.canCreateNewStandaloneFundraiser,
    required this.canCreateNewStandalonePersonalFundraiser,
    required this.canBeTaggedAsSponsor,
    required this.canSeeSupportInbox,
    required this.canSeeSupportInboxV1,
    required this.totalIgtvVideos,
    required this.hasVideos,
    required this.totalClipsCount,
    required this.hasSavedItems,
    required this.totalArEffects,
    required this.reelAutoArchive,
    required this.isProfileActionNeeded,
    required this.usertagsCount,
    required this.usertagReviewEnabled,
    required this.isNeedy,
    required this.isInterestAccount,
    required this.hdProfilePicVersions,
    required this.hdProfilePicUrlInfo,
    required this.hasPlacedOrders,
    required this.fbpayExperienceEnabled,
    required this.showConversionEditEntry,
    required this.aggregatePromoteEngagement,
    required this.allowedCommenterType,
    required this.hasHighlightReels,
    required this.hasGuides,
    required this.isEligibleToShowFbCrossSharingNux,
    required this.pageIdForNewSumaBizAccount,
    required this.canTagProductsFromMerchants,
    required this.creatorShoppingInfo,
    required this.eligibleShoppingSignupEntrypoints,
    required this.isIgdProductPickerEnabled,
    required this.isEligibleForAffiliateShopOnboarding,
    required this.eligibleShoppingFormats,
    required this.needsToAcceptShoppingSellerOnboardingTerms,
    required this.isShoppingSettingsEnabled,
    required this.isShoppingCommunityContentEnabled,
    required this.isShoppingAutoHighlightEligible,
    required this.isShoppingCatalogSourceSelectionEnabled,
    required this.isBusiness,
    required this.professionalConversionSuggestedAccountType,
    required this.accountType,
    required this.isCallToActionEnabled,
    required this.interopMessagingUserFbid,
    required this.bioLinks,
    required this.canAddFbGroupLinkOnProfile,
    required this.allowMentionSetting,
    required this.allowTagSetting,
    required this.limitedInteractionsEnabled,
    required this.isHideMoreCommentEnabled,
    required this.canSeePrimaryCountryInSettings,
    required this.transparencyProductEnabled,
    required this.personalAccountAdsPageName,
    required this.personalAccountAdsPageId,
    required this.accountBadges,
    required this.whatsappNumber,
    required this.hasEligibleWhatsappLinkingCategory,
    required this.pronouns,
    required this.fbidV2,
    required this.isMutedWordsGlobalEnabled,
    required this.isMutedWordsCustomEnabled,
    required this.fanClubInfo,
    required this.hasNftPosts,
    required this.likedClipsCount,
    required this.allMediaCount,
    required this.includeDirectBlacklistStatus,
    required this.canFollowHashtag,
    required this.isPotentialBusiness,
    required this.requestContactEnabled,
    required this.robiFeedbackSource,
    required this.isMemorialized,
    required this.openExternalUrlWithInAppBrowser,
    required this.hasExclusiveFeedContent,
    required this.hasFanClubSubscriptions,
    required this.bestiesCount,
    required this.showBestiesBadge,
    required this.recentlyBestiedByCount,
    required this.nametag,
    required this.existingUserAgeCollectionEnabled,
    required this.aboutYourAccountBloksEntrypointEnabled,
    required this.autoExpandingChaining,
    required this.showPostInsightsEntryPoint,
    required this.feedPostReshareDisabled,
    required this.autoExpandChaining,
    required this.isNewToInstagram,
    required this.highlightReshareDisabled,
  });

  final dynamic pk;
  final dynamic username;
  final dynamic fullName;
  final bool? isPrivate;
  final dynamic profilePicUrl;
  final bool? isVerified;
  final dynamic followFrictionType;
  final bool? hasAnonymousProfilePicture;
  final dynamic mediaCount;
  final dynamic followerCount;
  final dynamic followingCount;
  final dynamic followingTagCount;
  final bool? isSupervisionFeaturesEnabled;
  final dynamic biography;
  final dynamic externalUrl;
  final bool? showFbLinkOnProfile;
  final dynamic primaryProfileLinkType;
  final bool? canBoostPost;
  final bool? canSeeOrganicInsights;
  final bool? showInsightsTerms;
  final bool? canConvertToBusiness;
  final bool? canCreateSponsorTags;
  final bool? isAllowedToCreateStandaloneNonprofitFundraisers;
  final bool? isAllowedToCreateStandalonePersonalFundraisers;
  final bool? canCreateNewStandaloneFundraiser;
  final bool? canCreateNewStandalonePersonalFundraiser;
  final bool? canBeTaggedAsSponsor;
  final bool? canSeeSupportInbox;
  final bool? canSeeSupportInboxV1;
  final dynamic totalIgtvVideos;
  final bool? hasVideos;
  final dynamic totalClipsCount;
  final bool? hasSavedItems;
  final dynamic totalArEffects;
  final dynamic reelAutoArchive;
  final bool? isProfileActionNeeded;
  final dynamic usertagsCount;
  final bool? usertagReviewEnabled;
  final bool? isNeedy;
  final bool? isInterestAccount;
  final List<HdProfilePic>? hdProfilePicVersions;
  final HdProfilePic? hdProfilePicUrlInfo;
  final bool? hasPlacedOrders;
  final bool? fbpayExperienceEnabled;
  final bool? showConversionEditEntry;
  final bool? aggregatePromoteEngagement;
  final dynamic allowedCommenterType;
  final bool? hasHighlightReels;
  final bool? hasGuides;
  final bool? isEligibleToShowFbCrossSharingNux;
  final dynamic pageIdForNewSumaBizAccount;
  final bool? canTagProductsFromMerchants;
  final CreatorShoppingInfo? creatorShoppingInfo;
  final List<dynamic>? eligibleShoppingSignupEntrypoints;
  final bool? isIgdProductPickerEnabled;
  final bool? isEligibleForAffiliateShopOnboarding;
  final List<dynamic>? eligibleShoppingFormats;
  final bool? needsToAcceptShoppingSellerOnboardingTerms;
  final bool? isShoppingSettingsEnabled;
  final bool? isShoppingCommunityContentEnabled;
  final bool? isShoppingAutoHighlightEligible;
  final bool? isShoppingCatalogSourceSelectionEnabled;
  final bool? isBusiness;
  final dynamic professionalConversionSuggestedAccountType;
  final dynamic accountType;
  final dynamic isCallToActionEnabled;
  final dynamic interopMessagingUserFbid;
  final List<dynamic>? bioLinks;
  final bool? canAddFbGroupLinkOnProfile;
  final dynamic allowMentionSetting;
  final dynamic allowTagSetting;
  final bool? limitedInteractionsEnabled;
  final bool? isHideMoreCommentEnabled;
  final bool? canSeePrimaryCountryInSettings;
  final bool? transparencyProductEnabled;
  final dynamic personalAccountAdsPageName;
  final dynamic personalAccountAdsPageId;
  final List<dynamic>? accountBadges;
  final dynamic whatsappNumber;
  final dynamic hasEligibleWhatsappLinkingCategory;
  final List<dynamic>? pronouns;
  final dynamic fbidV2;
  final bool? isMutedWordsGlobalEnabled;
  final bool? isMutedWordsCustomEnabled;
  final FanClubInfo? fanClubInfo;
  final bool? hasNftPosts;
  final dynamic likedClipsCount;
  final dynamic allMediaCount;
  final bool? includeDirectBlacklistStatus;
  final bool? canFollowHashtag;
  final bool? isPotentialBusiness;
  final bool? requestContactEnabled;
  final dynamic robiFeedbackSource;
  final bool? isMemorialized;
  final bool? openExternalUrlWithInAppBrowser;
  final bool? hasExclusiveFeedContent;
  final bool? hasFanClubSubscriptions;
  final dynamic bestiesCount;
  final bool? showBestiesBadge;
  final dynamic recentlyBestiedByCount;
  final dynamic nametag;
  final bool? existingUserAgeCollectionEnabled;
  final bool? aboutYourAccountBloksEntrypointEnabled;
  final bool? autoExpandingChaining;
  final bool? showPostInsightsEntryPoint;
  final bool? feedPostReshareDisabled;
  final bool? autoExpandChaining;
  final bool? isNewToInstagram;
  final bool? highlightReshareDisabled;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        pk: json["pk"] == null ? null : json["pk"],
        username: json["username"] == null ? null : json["username"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        isPrivate: json["is_private"] == null ? null : json["is_private"],
        profilePicUrl:
            json["profile_pic_url"] == null ? null : json["profile_pic_url"],
        isVerified: json["is_verified"] == null ? null : json["is_verified"],
        followFrictionType: json["follow_friction_type"] == null
            ? null
            : json["follow_friction_type"],
        hasAnonymousProfilePicture:
            json["has_anonymous_profile_picture"] == null
                ? null
                : json["has_anonymous_profile_picture"],
        mediaCount: json["media_count"] == null ? null : json["media_count"],
        followerCount:
            json["follower_count"] == null ? null : json["follower_count"],
        followingCount:
            json["following_count"] == null ? null : json["following_count"],
        followingTagCount: json["following_tag_count"] == null
            ? null
            : json["following_tag_count"],
        isSupervisionFeaturesEnabled:
            json["is_supervision_features_enabled"] == null
                ? null
                : json["is_supervision_features_enabled"],
        biography: json["biography"] == null ? null : json["biography"],
        externalUrl: json["external_url"] == null ? null : json["external_url"],
        showFbLinkOnProfile: json["show_fb_link_on_profile"] == null
            ? null
            : json["show_fb_link_on_profile"],
        primaryProfileLinkType: json["primary_profile_link_type"] == null
            ? null
            : json["primary_profile_link_type"],
        canBoostPost:
            json["can_boost_post"] == null ? null : json["can_boost_post"],
        canSeeOrganicInsights: json["can_see_organic_insights"] == null
            ? null
            : json["can_see_organic_insights"],
        showInsightsTerms: json["show_insights_terms"] == null
            ? null
            : json["show_insights_terms"],
        canConvertToBusiness: json["can_convert_to_business"] == null
            ? null
            : json["can_convert_to_business"],
        canCreateSponsorTags: json["can_create_sponsor_tags"] == null
            ? null
            : json["can_create_sponsor_tags"],
        isAllowedToCreateStandaloneNonprofitFundraisers:
            json["is_allowed_to_create_standalone_nonprofit_fundraisers"] ==
                    null
                ? null
                : json["is_allowed_to_create_standalone_nonprofit_fundraisers"],
        isAllowedToCreateStandalonePersonalFundraisers:
            json["is_allowed_to_create_standalone_personal_fundraisers"] == null
                ? null
                : json["is_allowed_to_create_standalone_personal_fundraisers"],
        canCreateNewStandaloneFundraiser:
            json["can_create_new_standalone_fundraiser"] == null
                ? null
                : json["can_create_new_standalone_fundraiser"],
        canCreateNewStandalonePersonalFundraiser:
            json["can_create_new_standalone_personal_fundraiser"] == null
                ? null
                : json["can_create_new_standalone_personal_fundraiser"],
        canBeTaggedAsSponsor: json["can_be_tagged_as_sponsor"] == null
            ? null
            : json["can_be_tagged_as_sponsor"],
        canSeeSupportInbox: json["can_see_support_inbox"] == null
            ? null
            : json["can_see_support_inbox"],
        canSeeSupportInboxV1: json["can_see_support_inbox_v1"] == null
            ? null
            : json["can_see_support_inbox_v1"],
        totalIgtvVideos: json["total_igtv_videos"] == null
            ? null
            : json["total_igtv_videos"],
        hasVideos: json["has_videos"] == null ? null : json["has_videos"],
        totalClipsCount: json["total_clips_count"] == null
            ? null
            : json["total_clips_count"],
        hasSavedItems:
            json["has_saved_items"] == null ? null : json["has_saved_items"],
        totalArEffects:
            json["total_ar_effects"] == null ? null : json["total_ar_effects"],
        reelAutoArchive: json["reel_auto_archive"] == null
            ? null
            : json["reel_auto_archive"],
        isProfileActionNeeded: json["is_profile_action_needed"] == null
            ? null
            : json["is_profile_action_needed"],
        usertagsCount:
            json["usertags_count"] == null ? null : json["usertags_count"],
        usertagReviewEnabled: json["usertag_review_enabled"] == null
            ? null
            : json["usertag_review_enabled"],
        isNeedy: json["is_needy"] == null ? null : json["is_needy"],
        isInterestAccount: json["is_interest_account"] == null
            ? null
            : json["is_interest_account"],
        hdProfilePicVersions: json["hd_profile_pic_versions"] == null
            ? null
            : List<HdProfilePic>.from(json["hd_profile_pic_versions"]
                .map((x) => HdProfilePic.fromJson(x))),
        hdProfilePicUrlInfo:
            HdProfilePic.fromJson(json["hd_profile_pic_url_info"]),
        hasPlacedOrders: json["has_placed_orders"] == null
            ? null
            : json["has_placed_orders"],
        fbpayExperienceEnabled: json["fbpay_experience_enabled"] == null
            ? null
            : json["fbpay_experience_enabled"],
        showConversionEditEntry: json["show_conversion_edit_entry"] == null
            ? null
            : json["show_conversion_edit_entry"],
        aggregatePromoteEngagement: json["aggregate_promote_engagement"] == null
            ? null
            : json["aggregate_promote_engagement"],
        allowedCommenterType: json["allowed_commenter_type"] == null
            ? null
            : json["allowed_commenter_type"],
        hasHighlightReels: json["has_highlight_reels"] == null
            ? null
            : json["has_highlight_reels"],
        hasGuides: json["has_guides"] == null ? null : json["has_guides"],
        isEligibleToShowFbCrossSharingNux:
            json["is_eligible_to_show_fb_cross_sharing_nux"] == null
                ? null
                : json["is_eligible_to_show_fb_cross_sharing_nux"],
        pageIdForNewSumaBizAccount: json["page_id_for_new_suma_biz_account"],
        canTagProductsFromMerchants:
            json["can_tag_products_from_merchants"] == null
                ? null
                : json["can_tag_products_from_merchants"],
        creatorShoppingInfo: json["creator_shopping_info"] == null
            ? null
            : CreatorShoppingInfo.fromJson(json["creator_shopping_info"]),
        eligibleShoppingSignupEntrypoints:
            json["eligible_shopping_signup_entrypoints"] == null
                ? null
                : List<dynamic>.from(
                    json["eligible_shopping_signup_entrypoints"].map((x) => x)),
        isIgdProductPickerEnabled: json["is_igd_product_picker_enabled"],
        isEligibleForAffiliateShopOnboarding:
            json["is_eligible_for_affiliate_shop_onboarding"] == null
                ? null
                : json["is_eligible_for_affiliate_shop_onboarding"],
        eligibleShoppingFormats: json["eligible_shopping_formats"] == null
            ? null
            : List<dynamic>.from(
                json["eligible_shopping_formats"].map((x) => x)),
        needsToAcceptShoppingSellerOnboardingTerms:
            json["needs_to_accept_shopping_seller_onboarding_terms"] == null
                ? null
                : json["needs_to_accept_shopping_seller_onboarding_terms"],
        isShoppingSettingsEnabled: json["is_shopping_settings_enabled"] == null
            ? null
            : json["is_shopping_settings_enabled"],
        isShoppingCommunityContentEnabled:
            json["is_shopping_community_content_enabled"] == null
                ? null
                : json["is_shopping_community_content_enabled"],
        isShoppingAutoHighlightEligible:
            json["is_shopping_auto_highlight_eligible"] == null
                ? null
                : json["is_shopping_auto_highlight_eligible"],
        isShoppingCatalogSourceSelectionEnabled:
            json["is_shopping_catalog_source_selection_enabled"] == null
                ? null
                : json["is_shopping_catalog_source_selection_enabled"],
        isBusiness: json["is_business"] == null ? null : json["is_business"],
        professionalConversionSuggestedAccountType:
            json["professional_conversion_suggested_account_type"] == null
                ? null
                : json["professional_conversion_suggested_account_type"],
        accountType: json["account_type"] == null ? null : json["account_type"],
        isCallToActionEnabled: json["is_call_to_action_enabled"],
        interopMessagingUserFbid: json["interop_messaging_user_fbid"] == null
            ? null
            : json["interop_messaging_user_fbid"],
        bioLinks: json["bio_links"] == null
            ? null
            : List<dynamic>.from(json["bio_links"].map((x) => x)),
        canAddFbGroupLinkOnProfile:
            json["can_add_fb_group_link_on_profile"] == null
                ? null
                : json["can_add_fb_group_link_on_profile"],
        allowMentionSetting: json["allow_mention_setting"] == null
            ? null
            : json["allow_mention_setting"],
        allowTagSetting: json["allow_tag_setting"] == null
            ? null
            : json["allow_tag_setting"],
        limitedInteractionsEnabled: json["limited_interactions_enabled"] == null
            ? null
            : json["limited_interactions_enabled"],
        isHideMoreCommentEnabled: json["is_hide_more_comment_enabled"] == null
            ? null
            : json["is_hide_more_comment_enabled"],
        canSeePrimaryCountryInSettings:
            json["can_see_primary_country_in_settings"] == null
                ? null
                : json["can_see_primary_country_in_settings"],
        transparencyProductEnabled: json["transparency_product_enabled"] == null
            ? null
            : json["transparency_product_enabled"],
        personalAccountAdsPageName: json["personal_account_ads_page_name"],
        personalAccountAdsPageId: json["personal_account_ads_page_id"],
        accountBadges: json["account_badges"] == null
            ? null
            : List<dynamic>.from(json["account_badges"].map((x) => x)),
        whatsappNumber:
            json["whatsapp_number"] == null ? null : json["whatsapp_number"],
        hasEligibleWhatsappLinkingCategory:
            json["has_eligible_whatsapp_linking_category"],
        pronouns: json["pronouns"] == null
            ? null
            : List<dynamic>.from(json["pronouns"].map((x) => x)),
        fbidV2: json["fbid_v2"] == null ? null : json["fbid_v2"],
        isMutedWordsGlobalEnabled: json["is_muted_words_global_enabled"] == null
            ? null
            : json["is_muted_words_global_enabled"],
        isMutedWordsCustomEnabled: json["is_muted_words_custom_enabled"] == null
            ? null
            : json["is_muted_words_custom_enabled"],
        fanClubInfo: FanClubInfo.fromJson(json["fan_club_info"]),
        hasNftPosts:
            json["has_nft_posts"] == null ? null : json["has_nft_posts"],
        likedClipsCount: json["liked_clips_count"] == null
            ? null
            : json["liked_clips_count"],
        allMediaCount:
            json["all_media_count"] == null ? null : json["all_media_count"],
        includeDirectBlacklistStatus:
            json["include_direct_blacklist_status"] == null
                ? null
                : json["include_direct_blacklist_status"],
        canFollowHashtag: json["can_follow_hashtag"] == null
            ? null
            : json["can_follow_hashtag"],
        isPotentialBusiness: json["is_potential_business"] == null
            ? null
            : json["is_potential_business"],
        requestContactEnabled: json["request_contact_enabled"] == null
            ? null
            : json["request_contact_enabled"],
        robiFeedbackSource: json["robi_feedback_source"],
        isMemorialized:
            json["is_memorialized"] == null ? null : json["is_memorialized"],
        openExternalUrlWithInAppBrowser:
            json["open_external_url_with_in_app_browser"] == null
                ? null
                : json["open_external_url_with_in_app_browser"],
        hasExclusiveFeedContent: json["has_exclusive_feed_content"] == null
            ? null
            : json["has_exclusive_feed_content"],
        hasFanClubSubscriptions: json["has_fan_club_subscriptions"] == null
            ? null
            : json["has_fan_club_subscriptions"],
        bestiesCount:
            json["besties_count"] == null ? null : json["besties_count"],
        showBestiesBadge: json["show_besties_badge"] == null
            ? null
            : json["show_besties_badge"],
        recentlyBestiedByCount: json["recently_bestied_by_count"] == null
            ? null
            : json["recently_bestied_by_count"],
        nametag: json["nametag"],
        existingUserAgeCollectionEnabled:
            json["existing_user_age_collection_enabled"] == null
                ? null
                : json["existing_user_age_collection_enabled"],
        aboutYourAccountBloksEntrypointEnabled:
            json["about_your_account_bloks_entrypoint_enabled"] == null
                ? null
                : json["about_your_account_bloks_entrypoint_enabled"],
        autoExpandingChaining: json["auto_expanding_chaining"] == null
            ? null
            : json["auto_expanding_chaining"],
        showPostInsightsEntryPoint:
            json["show_post_insights_entry_point"] == null
                ? null
                : json["show_post_insights_entry_point"],
        feedPostReshareDisabled: json["feed_post_reshare_disabled"] == null
            ? null
            : json["feed_post_reshare_disabled"],
        autoExpandChaining: json["auto_expand_chaining"] == null
            ? null
            : json["auto_expand_chaining"],
        isNewToInstagram: json["is_new_to_instagram"] == null
            ? null
            : json["is_new_to_instagram"],
        highlightReshareDisabled: json["highlight_reshare_disabled"] == null
            ? null
            : json["highlight_reshare_disabled"],
      );
}

class CreatorShoppingInfo {
  CreatorShoppingInfo({
    required this.linkedMerchantAccounts,
  });

  final List<dynamic>? linkedMerchantAccounts;

  factory CreatorShoppingInfo.fromJson(Map<String, dynamic> json) =>
      CreatorShoppingInfo(
        linkedMerchantAccounts:
            List<dynamic>.from(json["linked_merchant_accounts"].map((x) => x)),
      );
}

class FanClubInfo {
  FanClubInfo({
    required this.fanClubId,
    required this.fanClubName,
  });

  final dynamic fanClubId;
  final dynamic fanClubName;

  factory FanClubInfo.fromJson(Map<String, dynamic> json) => FanClubInfo(
        fanClubId: json["fan_club_id"],
        fanClubName: json["fan_club_name"],
      );

  Map<String, dynamic> toJson() => {
        "fan_club_id": fanClubId,
        "fan_club_name": fanClubName,
      };
}

class HdProfilePic {
  HdProfilePic({
    required this.width,
    required this.height,
    required this.url,
  });

  final int width;
  final int height;
  final String url;

  factory HdProfilePic.fromJson(Map<String, dynamic> json) => HdProfilePic(
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
