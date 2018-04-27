Pod::Spec.new do |s|
    s.name = 'UrbanPiperSDK'
    s.version = '1.0.0'
    s.summary = 'The core framework code for iOS apps'
    s.homepage = 'https://urbanpiper.com'
    s.authors = { 'UrbanPiper' => 'support@urbanpiper.com' }
    s.source = { :git => 'https://github.com/urbanpiper/ios-sdk.git', :tag => s.version }
    
    s.ios.deployment_target = '9.0'
    
    s.source_files = 'UrbanPiper/UrbanPiper/*.swift'
    s.dependency 'FirebaseMessaging'
    s.dependency 'Firebase/RemoteConfig'
    s.dependency 'GooglePlaces'
    s.dependency 'GoogleMaps'
    s.dependency 'GoogleAnalytics'
    s.dependency 'Mixpanel-swift'
    s.dependency 'AppsFlyerFramework'
end
