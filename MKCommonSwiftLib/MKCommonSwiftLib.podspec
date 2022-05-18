#
# Be sure to run `pod lib lint MKCommonSwiftLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKCommonSwiftLib'
  s.version          = '0.1.0'
  s.summary          = 'MKCommonSwiftLib is a lib of swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is a lib of swift, for quickly create swift develop
                       DESC

  s.homepage         = 'https://github.com/mokong/MWCommonSwiftLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MorganWang' => 'a525325614@163.com' }
  s.source           = { :git => 'https://github.com/mokong/MWCommonSwiftLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.source_files = 'MKCommonSwiftLib/Classes/*.{swift}'
  s.ios.deployment_target = '10.0'  

  #View
  s.subspec 'Base' do |a|
    a.source_files = 'MKCommonSwiftLib/Classes/Base/*.{swift}'
  end

    #Const
  s.subspec 'Const' do |v|
    v.source_files = 'MKCommonSwiftLib/Classes/Const/*.{swift}'
  end

    #Extension
  s.subspec 'Extension' do |b|
      b.source_files = 'MKCommonSwiftLib/Classes/Extension/*'
      b.subspec 'Foundation' do |f|
          f.source_files = 'MKCommonSwiftLib/Classes/Extension/Foundation/*.{swift}'
      end
      
      b.subspec 'UIKit' do |c|
          c.source_files = 'MKCommonSwiftLib/Classes/Extension/UIKit/*.{swift}'
      end
  end

  # s.resource_bundles = {
  #   'MKCommonSwiftLib' => ['MKCommonSwiftLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'AVFoundation', 'Photos'
  s.dependency 'SnapKit', '~> 5.0.0'
  s.dependency 'LanguageManager-iOS'

end
