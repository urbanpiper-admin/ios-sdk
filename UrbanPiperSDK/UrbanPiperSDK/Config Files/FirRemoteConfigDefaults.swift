//
//	FirRemoteConfigDefaults.swift
//
//	Create by Vidhyadharan Mohanram on 30/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import FirebaseRemoteConfig

@objc public class FirRemoteConfigDefaults : NSObject {

    public static let shared = FirRemoteConfigDefaults()

    let remoteConfig: RemoteConfig = {
        let remoteConfig = RemoteConfig.remoteConfig()

        #if DEBUG
        let remoteConfigSettings = RemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = remoteConfigSettings
        #endif

        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        return remoteConfig
    }()

	public var allowCashForOrderCheckout : Bool!
	public var altDeliveryTimeText : String!
	public var apiKey : String!
	public var apiUsername : String!
	public var appsFlyerDevAppid : String!
	public var appsFlyerDevKey : String!
    public var applyWalletCredits: Bool!
	public var badRatingThreshold : Int!
	public var bizAppId : String!
	public var bizAppName : String!
	public var bizLogoUrl : String!
    public var bizCountry2LetterCode: String!
	public var cacheDurationSecs : Int!
	public var categoryLayoutGrid : Bool!
    public var isdCodes : [[String : String]]!
	public var defaultCountryCode : String!
	public var dfltPymntOpt : String!
	public var dfltTabToShow : String!
	public var disableWalletReload : Bool!
	public var enableCaching : Bool!
    public var showBanners : Bool!
	public var enableItemDirectLoading : Bool!
	public var enablePostOrderFeedback : Bool!
	public var enableSocialLogin : Bool!
	public var enableTimeSlots : Bool!
	public var enforceMinOffsetTime : Bool!
	public var errAccountExists : String!
	public var errCouponInvalid : String!
	public var feedbackScale : Int!
	public var forcePaymentOptSel : Bool!
	public var googleOauthClientId : String!
	public var googlePlacesApiKey : String!
	public var helpEmail : String!
	public var helpPhone : String!
	public var hideCategoryScreen : Bool!
	public var hideLockedRewards : Bool!
	public var hidePoints : Bool!
	public var hotlineAppId : String!
	public var hotlineAppKey : String!
	public var hotlineEnable2way : Bool!
	public var inStorePrepaidEnabled : Bool!
	public var itemLayoutLandscape : Bool!
	public var itemQtyRestrictToCurentStock : Bool!
	public var itemSearchEnabled : Bool!
    public var lblAlertConfirmationButtonTitle : String!
	public var lblCheckoutTax : String!
	public var lblCurrencySymbol : String!
	public var lblCurrencySymbolIso4217 : String!
	public var lblFeedbackQuestion : String!
	public var lblForgotPwd : String!
	public var lblItemTaxRateString : String!
	public var lblItemTaxesString : String!
	public var lblLoginHdr : String!
	public var lblOrderTaxString : String!
	public var lblOutOfStock : String!
	public var lblSignupHdr : String!
	public var lblSocialSignupHdr : String!
	public var locationMandatoryForItems : Bool!
	public var maxReloadAmt : Int!
	public var minOrderValue : Int!
	public var minReloadAmt : Int!
	public var minReloadBttnVal : Int!
	public var mixpanelProjectToken : String!
	public var moduleBookTable : Bool!
	public var moduleFaq : Bool!
	public var moduleFeedbackOld : Bool!
	public var moduleHelp : Bool!
	public var moduleHistory : Bool!
    public var moduleHome : Bool!
	public var moduleNotifications : Bool!
	public var moduleOffers : Bool!
	public var moduleOrdering : Bool!
	public var moduleReferral : Bool!
	public var moduleRewards : Bool!
	public var moduleRewardsOld : Bool!
    public var moduleSchedule : Bool!
	public var moduleSettings : Bool!
	public var moduleStoreLoc : Bool!
	public var moduleStoreLocOld : Bool!
	public var moduleWallet : Bool!
    public var moduleAboutUs : Bool!
	public var orderDeliveryOffsetSecs : Int!
	public var orderDetailDeliveryDtMsg : String!
	public var orderFeedbackMandatory : Bool!
	public var orderItemCount : Int!
	public var orderSuccessMsgExtra : String!
	public var orderTotalAlert : Bool!
	public var orderTotalAlertMsg : String!
	public var orderTotalDisclaimer : Bool!
	public var paymentGateway : String!
	public var pgRzpKey : String!
	public var promptForStore : Bool!
	public var promptInitialBalanceAlert : Bool!
	public var promptToChkAddress : Bool!
	public var reorderEnabled : Bool!
    public var simplClientId : String?
	public var showAltDeliveryTimeMsg : Bool!
	public var showDeliveryDateField : Bool!
	public var showDeliveryOpts : Bool!
	public var showItemCheck : Bool!
	public var showItemDesc : Bool!
	public var showItemInfoIcon : Bool!
	public var showLocBarAtPayment : Bool!
	public var showOrderConfirmationScreen : Bool!
	public var showSplRequest : Bool!
	public var sideMenu3rdPartEnabled : Bool!
	public var signupNameRequired : Bool!
	public var signupShowNameField : Bool!
	public var skipLogin : Bool!
	public var skipStoreTimingCheck : Bool!
	public var splashDisplayLengthMillis : Int!
	public var storeCacheExpiryMillis : Int!
	public var tabsExpandEqually : Bool!
	public var timeToElapseForFeebdackSecs : Int!
	public var toolbarNoShadow : Bool!
	public var usingHotline : Bool!
    public var aboutUsLink : String!


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
		bizAppId = remoteConfig["biz_app_id"].stringValue
		bizAppName = remoteConfig["biz_app_name"].stringValue
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
		enableItemDirectLoading = remoteConfig["enable_item_direct_loading"].boolValue
		enablePostOrderFeedback = remoteConfig["enable_post_order_feedback"].boolValue
		enableSocialLogin = remoteConfig["enable_social_login"].boolValue
		enableTimeSlots = remoteConfig["enable_time_slots"].boolValue
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
