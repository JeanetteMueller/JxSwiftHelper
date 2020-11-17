#
# Be sure to run `pod lib lint JxSwiftHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JxSwiftHelper'
  s.version          = '0.1.2'
  s.summary          = 'A Collection of Extensions and Helper to work faster'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC

  FileHelper: More Acces to the Filesystem
  Logging: Log your Message to console and dont when release your code
  PhotoOperations: Download or change Images
  String+Localized: Use "".localized as an easy way to translate strings
  String+md5: get hash from string
  String+SubString: the mising substring method
  
  URL+Helper: Work with your urls
  
                       DESC

  s.homepage         = 'https://github.com/JeanetteMueller/JxSwiftHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JeanetteMueller' => 'themaverick@themaverick.de' }
  s.source           = { :git => 'https://github.com/JeanetteMueller/JxSwiftHelper.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/JeanetteMueller'

#  s.ios.deployment_target = '11.0'
#  s.watchos.deployment_target = '5.0'
#  s.tvos.deployment_target = '11.0'
#
#  s.swift_versions = ['5.0', '5.1', '5.2', '5.3']
  
  s.source_files = 'Classes/*.swift'
  
  # s.resource_bundles = {
  #   'JxSwiftHelper' => ['JxSwiftHelper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
end
