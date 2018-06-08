Pod::Spec.new do |s|
    s.name = 'UrbanPiperSDK'
    s.version = '1.0.0'
    s.summary = 'The core framework code for iOS apps'
    s.homepage = 'https://urbanpiper.com'
    s.authors = { 'UrbanPiper' => 'support@urbanpiper.com' }
    s.source = { :git => 'https://github.com/urbanpiper/ios-sdk.git', :tag => s.version }
    s.static_framework = true

    s.ios.deployment_target = '9.0'
    
    s.source_files = ['UrbanPiperSDK/**/*.{h,swift}']
    s.dependency 'FirebaseMessaging'
    s.dependency 'Firebase/RemoteConfig'
    s.dependency 'GooglePlaces'
    s.dependency 'GoogleMaps'
    s.dependency 'GoogleAnalytics'
    s.dependency 'Mixpanel-swift'
    s.dependency 'AppsFlyerFramework'
    s.resources = ['UrbanPiperSDK/WLDetailOptionData.plist']

    s.prefix_header_contents = '#import "GAI.h"', '#import "GAIDictionaryBuilder.h"', '#import "GAIFields.h"'

    s.xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

    end
