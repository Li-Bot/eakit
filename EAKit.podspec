#
# Be sure to run `pod lib lint EAKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EAKit'
  s.version          = '0.1.3'
  s.summary          = 'Evolutionary Algorithms written in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
EAKit is a Framework of Evolutionary Algorithms written in Swift. It is fully generic, architecture (algorithms) based on (interchangeable) components, simple to use and you can build your own evolutionary algorithm by using existing components.
                       DESC

  s.homepage         = 'https://github.com/Li-Bot/eakit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'GNU GPLv3', :file => 'LICENSE' }
  s.author           = { 'Libor Polehna' => 'polehna.libor@gmail.com' }
  s.source           = { :git => 'https://github.com/Li-Bot/eakit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.swift_versions = '5.0'

  s.source_files = 'Sources/**/*.{h,m,swift}'
  
  # s.resource = '.../**/*.{xib,storyboard}'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
