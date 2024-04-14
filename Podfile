# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'OHHTTPStubs/Swift'
end

target 'MySurveyChallenge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MySurveyChallenge
  pod 'Alamofire'
  pod 'Japx'
  pod 'Japx/Alamofire'
  pod 'R.swift'
  pod 'Swinject'

  target 'MySurveyChallengeTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

  target 'MySurveyChallengeUITests' do
    # Pods for testing
    testing_pods
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end
