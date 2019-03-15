Pod::Spec.new do |s|
    s.name = 'UrbanPiper'
    s.version = '1.0.0'
    s.summary = 'The core framework code for iOS apps'
    s.homepage = 'https://urbanpiper.com'
    s.authors = { 'UrbanPiper' => 'support@urbanpiper.com' }
    s.source = { :git => 'https://github.com/urbanpiper/ios-sdk.git', :tag => s.version }
    s.static_framework = true

    s.ios.deployment_target = '9.0'
    
    s.source_files = ['UrbanPiper/**/*.{h,swift}']
    s.dependency 'FirebaseMessaging'
    s.dependency 'FirebaseRemoteConfig'
    s.dependency 'GooglePlaces'
    s.dependency 'GoogleMaps'
    s.dependency 'GoogleAnalytics'
    s.dependency 'Mixpanel-swift'
    s.dependency 'AppsFlyerFramework'
    s.dependency 'PhoneNumberKit'
    s.resources = ['UrbanPiper/Internal/WLDetailOptionData.plist']

    s.xcconfig = { 'SWIFT_INCLUDE_PATHS' => '"${PODS_TARGET_SRCROOT}/UrbanPiper/GoogleAnalyticsSDK/"' }
    s.pod_target_xcconfig = { 'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/GoogleAnalytics/Sources/"' }

    # This if-statement means we'll only run the main script if the GoogleAnalyticsSDK directory doesn't exist
    # Because otherwise the rest of the script causes a full recompile for anything where GoogleAnalytics is a dependency
    # Do a 'Clean Build Folder' to remove this directory and trigger the rest of the script to run

    s.script_phase = {
    :name => 'GoogleAnalytics Module',
    :execution_position => :before_compile,
    :script => 'cat <<EOF > "${PODS_TARGET_SRCROOT}/UrbanPiper/GoogleAnalyticsSDK/module.modulemap"
module GoogleAnalyticsSDK {
    header "$PODS_ROOT/GoogleAnalytics/Sources/GAI.h"
    header "$PODS_ROOT/GoogleAnalytics/Sources/GAIFields.h"
    header "$PODS_ROOT/GoogleAnalytics/Sources/GAIEcommerceFields.h"
    header "$PODS_ROOT/GoogleAnalytics/Sources/GAIDictionaryBuilder.h"
    export *
}'
}
end
