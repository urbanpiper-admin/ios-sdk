//
//	FirRemoteConfigDefaults.swift
//
//	Create by Vidhyadharan Mohanram on 30/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import FirebaseRemoteConfig

@objc public class FirRemoteConfigDefaults : NSObject {

    public static let shared: FirRemoteConfigDefaults = FirRemoteConfigDefaults()

    let remoteConfig: RemoteConfig = {
        let remoteConfig = RemoteConfig.remoteConfig()

        #if DEBUG
        let remoteConfigSettings: RemoteConfigSettings = RemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = remoteConfigSettings
        #endif

        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        return remoteConfig
    }()
    
    #if DEBUG
    public var customBannersState: Bool! {
        didSet {
            showBanners = customBannersState
        }
    }
    public var customapplyWalletCreditsState: Bool! {
        didSet {
            applyWalletCredits = customapplyWalletCreditsState
        }
    }
    #endif

	public private(set) var allowCashForOrderCheckout : Bool!
	public private(set) var altDeliveryTimeText : String!
	public private(set) var apiKey : String!
	public private(set) var apiUsername : String!
	public private(set) var appsFlyerDevAppid : String!
	public private(set) var appsFlyerDevKey : String!
    public private(set) var applyWalletCredits: Bool!
	public private(set) var badRatingThreshold : Int!
	public private(set) var bizId : String!
	public private(set) var bizName : String!
	public private(set) var bizLogoUrl : String!
    public private(set) var bizCountry2LetterCode: String!
	public private(set) var cacheDurationSecs : Int!
	public private(set) var categoryLayoutGrid : Bool!
    public private(set) var isdCodes : [[String : String]]!
	public private(set) var defaultCountryCode : String!
	public private(set) var dfltPymntOpt : String!
	public private(set) var dfltTabToShow : String!
	public private(set) var disableWalletReload : Bool!
	public private(set) var enableCaching : Bool!
    public private(set) var showBanners : Bool!
    public private(set) var showStoreOpeningTime : Bool!
    public private(set) var showFeaturedItems : Bool!
    public private(set) var enableItemUpselling : Bool!
    public private(set) var enableFilterSort : Bool!
	public private(set) var enableItemDirectLoading : Bool!
	public private(set) var enablePostOrderFeedback : Bool!
	public private(set) var enableSocialLogin : Bool!
	public private(set) var enableTimeSlots : Bool!
	public private(set) var enforceMinOffsetTime : Bool!
	public private(set) var errAccountExists : String!
	public private(set) var errCouponInvalid : String!
	public private(set) var feedbackScale : Int!
	public private(set) var forcePaymentOptSel : Bool!
	public private(set) var googleOauthClientId : String!
	public private(set) var googlePlacesApiKey : String!
	public private(set) var helpEmail : String!
	public private(set) var helpPhone : String!
	public private(set) var hideCategoryScreen : Bool!
	public private(set) var hideLockedRewards : Bool!
	public private(set) var hidePoints : Bool!
	public private(set) var hotlineAppId : String!
	public private(set) var hotlineAppKey : String!
	public private(set) var hotlineEnable2way : Bool!
	public private(set) var inStorePrepaidEnabled : Bool!
	public private(set) var itemLayoutLandscape : Bool!
	public private(set) var itemQtyRestrictToCurentStock : Bool!
	public private(set) var itemSearchEnabled : Bool!
    public private(set) var lblAlertConfirmationButtonTitle : String!
	public private(set) var lblCheckoutTax : String!
	public private(set) var lblCurrencySymbol : String!
	public private(set) var lblCurrencySymbolIso4217 : String!
	public private(set) var lblFeedbackQuestion : String!
	public private(set) var lblForgotPwd : String!
	public private(set) var lblItemTaxRateString : String!
	public private(set) var lblItemTaxesString : String!
	public private(set) var lblLoginHdr : String!
	public private(set) var lblOrderTaxString : String!
	public private(set) var lblOutOfStock : String!
	public private(set) var lblSignupHdr : String!
	public private(set) var lblSocialSignupHdr : String!
	public private(set) var locationMandatoryForItems : Bool!
	public private(set) var maxReloadAmt : Int!
    public private(set) var maxPreOrderDate : Int!
	public private(set) var minOrderValue : Int!
	public private(set) var minReloadAmt : Int!
	public private(set) var minReloadBttnVal : Int!
	public private(set) var mixpanelProjectToken : String!
	public private(set) var moduleBookTable : Bool!
	public private(set) var moduleFaq : Bool!
	public private(set) var moduleFeedbackOld : Bool!
	public private(set) var moduleHelp : Bool!
	public private(set) var moduleHistory : Bool!
    public private(set) var moduleHome : Bool!
	public private(set) var moduleNotifications : Bool!
	public private(set) var moduleOffers : Bool!
	public private(set) var moduleOrdering : Bool!
	public private(set) var moduleReferral : Bool!
	public private(set) var moduleRewards : Bool!
	public private(set) var moduleRewardsOld : Bool!
    public private(set) var moduleSchedule : Bool!
	public private(set) var moduleSettings : Bool!
	public private(set) var moduleStoreLoc : Bool!
	public private(set) var moduleStoreLocOld : Bool!
	public private(set) var moduleWallet : Bool!
    public private(set) var moduleAboutUs : Bool!
	public private(set) var orderDeliveryOffsetSecs : Int!
	public private(set) var orderDetailDeliveryDtMsg : String!
	public private(set) var orderFeedbackMandatory : Bool!
	public private(set) var orderItemCount : Int!
	public private(set) var orderSuccessMsgExtra : String!
	public private(set) var orderTotalAlert : Bool!
	public private(set) var orderTotalAlertMsg : String!
	public private(set) var orderTotalDisclaimer : Bool!
	public private(set) var paymentGateway : String!
	public private(set) var pgRzpKey : String!
	public private(set) var promptForStore : Bool!
	public private(set) var promptInitialBalanceAlert : Bool!
	public private(set) var promptToChkAddress : Bool!
	public private(set) var reorderEnabled : Bool!
    public private(set) var simplClientId : String?
	public private(set) var showAltDeliveryTimeMsg : Bool!
	public private(set) var showDeliveryDateField : Bool!
	public private(set) var showDeliveryOpts : Bool!
	public private(set) var showItemCheck : Bool!
	public private(set) var showItemDesc : Bool!
	public private(set) var showItemInfoIcon : Bool!
	public private(set) var showLocBarAtPayment : Bool!
	public private(set) var showOrderConfirmationScreen : Bool!
	public private(set) var showSplRequest : Bool!
	public private(set) var sideMenu3rdPartEnabled : Bool!
	public private(set) var signupNameRequired : Bool!
	public private(set) var signupShowNameField : Bool!
	public private(set) var skipLogin : Bool!
	public private(set) var skipStoreTimingCheck : Bool!
	public private(set) var splashDisplayLengthMillis : Int!
	public private(set) var storeCacheExpiryMillis : Int!
	public private(set) var tabsExpandEqually : Bool!
	public private(set) var timeToElapseForFeebdackSecs : Int!
	public private(set) var toolbarNoShadow : Bool!
	public private(set) var usingHotline : Bool!
    public private(set) var aboutUsLink : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    override private init() {
        super.init()
        refreshValues()
    }

    @objc public func refreshValues() {
		allowCashForOrderCheckout = remoteConfig["allow_cash_for_order_checkout"].boolValue
		altDeliveryTimeText = remoteConfig["alt_delivery_time_text"].stringValue
        #if DEBUG
            apiKey = remoteConfig["dev_api_key"].stringValue
            apiUsername = remoteConfig["dev_api_username"].stringValue
        #else
            apiKey = remoteConfig["api_key"].stringValue
            apiUsername = remoteConfig["api_username"].stringValue
        #endif
		appsFlyerDevAppid = remoteConfig["apps_flyer_dev_appid"].stringValue
		appsFlyerDevKey = remoteConfig["apps_flyer_dev_key"].stringValue
        applyWalletCredits = remoteConfig["apply_wallet_credits"].boolValue
		badRatingThreshold = remoteConfig["bad_rating_threshold"].numberValue as? Int
		bizId = remoteConfig["biz_id"].stringValue
		bizName = remoteConfig["biz_name"].stringValue
		bizLogoUrl = remoteConfig["biz_logo_url"].stringValue
        bizCountry2LetterCode = remoteConfig["biz_country_2_letter_code"].stringValue
		cacheDurationSecs = remoteConfig["cache_duration_secs"].numberValue as? Int
		categoryLayoutGrid = remoteConfig["category_layout_grid"].boolValue
        let isdCodesString = remoteConfig["isd_codes"].stringValue
        isdCodes = isdCodesString?.array as? [[String : String]] ?? []
		defaultCountryCode = remoteConfig["default_country_code"].stringValue
		dfltPymntOpt = remoteConfig["dflt_pymnt_opt"].stringValue
		dfltTabToShow = remoteConfig["dflt_tab_to_show"].stringValue
		disableWalletReload = remoteConfig["disable_wallet_reload"].boolValue
		enableCaching = remoteConfig["enable_caching"].boolValue
        showBanners = remoteConfig["show_banners"].boolValue
        showStoreOpeningTime = remoteConfig["show_store_opening_time"].boolValue
        showFeaturedItems = remoteConfig["show_featured_items"].boolValue
        enableItemUpselling = remoteConfig["enable_item_upselling"].boolValue
        enableFilterSort = remoteConfig["enable_filter_sort"].boolValue
		enableItemDirectLoading = remoteConfig["enable_item_direct_loading"].boolValue
        #if DEBUG
        enableItemDirectLoading = false
        #endif
		enablePostOrderFeedback = remoteConfig["enable_post_order_feedback"].boolValue
		enableSocialLogin = remoteConfig["enable_social_login"].boolValue
		enableTimeSlots = remoteConfig["enable_time_slots"].boolValue
        #if DEBUG
        enableTimeSlots = true
        #endif
		enforceMinOffsetTime = remoteConfig["enforce_min_offset_time"].boolValue
		errAccountExists = remoteConfig["err_account_exists"].stringValue
		errCouponInvalid = remoteConfig["err_coupon_invalid"].stringValue
		feedbackScale = remoteConfig["feedback_scale"].numberValue as? Int
		forcePaymentOptSel = remoteConfig["force_payment_opt_sel"].boolValue
		googleOauthClientId = remoteConfig["google_oauth_client_id"].stringValue
		googlePlacesApiKey = remoteConfig["google_places_api_key"].stringValue
		helpEmail = remoteConfig["help_email"].stringValue
		helpPhone = remoteConfig["help_phone"].stringValue
		hideCategoryScreen = remoteConfig["hide_category_screen"].boolValue
		hideLockedRewards = remoteConfig["hide_locked_rewards"].boolValue
		hidePoints = remoteConfig["hide_points"].boolValue
		hotlineAppId = remoteConfig["hotline_app_id"].stringValue
		hotlineAppKey = remoteConfig["hotline_app_key"].stringValue
		hotlineEnable2way = remoteConfig["hotline_enable_2way"].boolValue
		inStorePrepaidEnabled = remoteConfig["in_store_prepaid_enabled"].boolValue
		itemLayoutLandscape = remoteConfig["item_layout_landscape"].boolValue
		itemQtyRestrictToCurentStock = remoteConfig["item_qty_restrict_to_curent_stock"].boolValue
		itemSearchEnabled = remoteConfig["item_search_enabled"].boolValue
        lblAlertConfirmationButtonTitle = remoteConfig["lbl_alert_confirmation_button_title"].stringValue
		lblCheckoutTax = remoteConfig["lbl_checkout_tax"].stringValue
		lblCurrencySymbol = remoteConfig["lbl_currency_symbol"].stringValue
		lblCurrencySymbolIso4217 = remoteConfig["lbl_currency_symbol_iso_4217"].stringValue
		lblFeedbackQuestion = remoteConfig["lbl_feedback_question"].stringValue
		lblForgotPwd = remoteConfig["lbl_forgot_pwd"].stringValue
		lblItemTaxRateString = remoteConfig["lbl_item_tax_rate_string"].stringValue
		lblItemTaxesString = remoteConfig["lbl_item_taxes_string"].stringValue
		lblLoginHdr = remoteConfig["lbl_login_hdr"].stringValue
		lblOrderTaxString = remoteConfig["lbl_order_tax_string"].stringValue
		lblOutOfStock = remoteConfig["lbl_out_of_stock"].stringValue
		lblSignupHdr = remoteConfig["lbl_signup_hdr"].stringValue
		lblSocialSignupHdr = remoteConfig["lbl_social_signup_hdr"].stringValue
		locationMandatoryForItems = remoteConfig["location_mandatory_for_items"].boolValue
		maxReloadAmt = remoteConfig["max_reload_amt"].numberValue as? Int
        maxPreOrderDate = remoteConfig["max_pre_order_date"].numberValue as? Int
		minOrderValue = remoteConfig["min_order_value"].numberValue as? Int
		minReloadAmt = remoteConfig["min_reload_amt"].numberValue as? Int
		minReloadBttnVal = remoteConfig["min_reload_bttn_val"].numberValue as? Int
		mixpanelProjectToken = remoteConfig["mixpanel_project_token"].stringValue
		moduleBookTable = remoteConfig["module_book_table"].boolValue
		moduleFaq = remoteConfig["module_faq"].boolValue
		moduleFeedbackOld = remoteConfig["module_feedback_old"].boolValue
		moduleHelp = remoteConfig["module_help"].boolValue
		moduleHistory = remoteConfig["module_history"].boolValue
        moduleHome = remoteConfig["module_home"].boolValue
		moduleNotifications = remoteConfig["module_notifications"].boolValue
		moduleOffers = remoteConfig["module_offers"].boolValue
		moduleOrdering = remoteConfig["module_ordering"].boolValue
		moduleReferral = remoteConfig["module_referral"].boolValue
		moduleRewards = remoteConfig["module_rewards"].boolValue
		moduleRewardsOld = remoteConfig["module_rewards_old"].boolValue
        moduleSchedule = remoteConfig["module_schedule"].boolValue
		moduleSettings = remoteConfig["module_settings"].boolValue
		moduleStoreLoc = remoteConfig["module_store_loc"].boolValue
		moduleStoreLocOld = remoteConfig["module_store_loc_old"].boolValue
		moduleWallet = remoteConfig["module_wallet"].boolValue
        moduleAboutUs = remoteConfig["module_about_us"].boolValue
		orderDeliveryOffsetSecs = remoteConfig["order_delivery_offset_secs"].numberValue as? Int
		orderDetailDeliveryDtMsg = remoteConfig["order_detail_delivery_dt_msg"].stringValue
		orderFeedbackMandatory = remoteConfig["order_feedback_mandatory"].boolValue
		orderItemCount = remoteConfig["order_item_count"].numberValue as? Int
		orderSuccessMsgExtra = remoteConfig["order_success_msg_extra"].stringValue
		orderTotalAlert = remoteConfig["order_total_alert"].boolValue
		orderTotalAlertMsg = remoteConfig["order_total_alert_msg"].stringValue
		orderTotalDisclaimer = remoteConfig["order_total_disclaimer"].boolValue
		paymentGateway = remoteConfig["payment_gateway"].stringValue
		pgRzpKey = remoteConfig["pg_rzp_key"].stringValue
		promptForStore = remoteConfig["prompt_for_store"].boolValue
		promptInitialBalanceAlert = remoteConfig["prompt_initial_balance_alert"].boolValue
		promptToChkAddress = remoteConfig["prompt_to_chk_address"].boolValue
		reorderEnabled = remoteConfig["reorder_enabled"].boolValue
        simplClientId = remoteConfig["simpl_client_id"].stringValue
		showAltDeliveryTimeMsg = remoteConfig["show_alt_delivery_time_msg"].boolValue
		showDeliveryDateField = remoteConfig["show_delivery_date_field"].boolValue
		showDeliveryOpts = remoteConfig["show_delivery_opts"].boolValue
		showItemCheck = remoteConfig["show_item_check"].boolValue
		showItemDesc = remoteConfig["show_item_desc"].boolValue
		showItemInfoIcon = remoteConfig["show_item_info_icon"].boolValue
		showLocBarAtPayment = remoteConfig["show_loc_bar_at_payment"].boolValue
		showOrderConfirmationScreen = remoteConfig["show_order_confirmation_screen"].boolValue
		showSplRequest = remoteConfig["show_spl_request"].boolValue
		sideMenu3rdPartEnabled = remoteConfig["side_menu3rd_part_enabled"].boolValue
		signupNameRequired = remoteConfig["signup_name_required"].boolValue
		signupShowNameField = remoteConfig["signup_show_name_field"].boolValue
		skipLogin = remoteConfig["skip_login"].boolValue
		skipStoreTimingCheck = remoteConfig["skip_store_timing_check"].boolValue
		splashDisplayLengthMillis = remoteConfig["splash_display_length_millis"].numberValue as? Int
		storeCacheExpiryMillis = remoteConfig["store_cache_expiry_millis"].numberValue as? Int
		tabsExpandEqually = remoteConfig["tabs_expand_equally"].boolValue
		timeToElapseForFeebdackSecs = remoteConfig["time_to_elapse_for_feebdack_secs"].numberValue as? Int
		toolbarNoShadow = remoteConfig["toolbar_no_shadow"].boolValue
		usingHotline = remoteConfig["using_hotline"].boolValue
        aboutUsLink = remoteConfig["about_us_link"].stringValue
	}

}
