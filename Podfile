# platform :ios, '9.0'
# don't update MessageKit

target 'MumsApp' do

use_frameworks!

pod 'Arcane', git: 'https://github.com/onmyway133/Arcane', :tag => '0.5.0'
pod 'Alamofire', '~> 4.5.1'
pod 'XCGLogger', '~> 5.0.1'
pod 'Crashlytics', '~> 3.9.3'
pod 'ReachabilitySwift', '~> 3'
pod 'FBSDKLoginKit', '~> 4.29.0'
pod 'GoogleMaps', '~> 2.6.0'
pod 'GooglePlaces', '~> 2.6.0'
pod 'GoogleSignIn', '~> 4.1.2'
pod 'SwipeCellKit', '~> 1.9.1'
pod 'MessageKit', '~> 0.10.2'
pod 'Segmentio', '~> 3.0'
pod 'Kingfisher', '~> 4.0'
pod 'SVProgressHUD', '~> 2.2.5'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'MessageKit'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end

  target 'MumsAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MumsAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
