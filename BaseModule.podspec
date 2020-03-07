#
# Be sure to run `pod lib lint BaseModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BaseModule'
  s.version          = '0.2.3'
  s.summary          = '基础组件库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
这是简单封装的一个分类组件库，待完善
                       DESC

  s.homepage         = 'https://gitee.com/luojiya/BaseModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '1049646716@qq.com' => '1049646716@qq.com' }
  s.source           = { :git => 'https://gitee.com/luojiya/BaseModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

 # s.source_files = 'BaseModule/Classes/**/*'
  
  s.subspec 'Base' do |b|
    b.source_files = 'BaseModule/Classes/Base/**/*'
  end

  s.subspec 'Category' do |c|
    c.source_files = 'BaseModule/Classes/Category/**/*'
  end

  s.subspec 'Network' do |n|
    n.source_files = 'BaseModule/Classes/Network/**/*'
    n.dependency 'AFNetworking'
    n.dependency 'SDWebImage'
  end

  s.subspec 'Tool' do |t|
    t.source_files = 'BaseModule/Classes/Tool/**/*'
  end
   
  # s.resource_bundles = {
  #   'BaseModule' => ['BaseModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
end
