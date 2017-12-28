#
# Be sure to run `pod lib lint WTLStickerPanel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WTLStickerPanel'
  s.version          = '1.0.0'
  s.summary          = 'A simple sticker panel'

  s.description      = <<-DESC
WTLStickerPanel is a view for select sticker to post to comment area.
                       DESC

  s.homepage         = 'https://github.com/daarkfish/WTLStickerPanel'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'daarkfish' => 'lwting@gmail.con' }
  s.source           = { :git => 'https://github.com/daarkfish/WTLStickerPanel.git', :tag => s.version.to_s }


  s.ios.deployment_target = '8.0'
  s.platform = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'WTLStickerPanel/Classes/**/*'
  
  s.resource_bundles = {
      'WTLStickerPanel' => ['WTLStickerPanel/Classes/*.xib']
  }

  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'YYWebImage'
end
