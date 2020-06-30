

Pod::Spec.new do |s|
  s.name             = 'XXPay'
  s.version          = '0.1.0'
  s.summary          = '聚合支付 -> (微信、支付宝、银联)'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/SilenceWater/XXPay'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Monster .' => 'wwwarehouse@163.com' }
  s.source           = { :git => 'https://github.com/SilenceWater/XXPay.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'XXPay/Classes/**/*'
  s.static_framework = true
  s.vendored_libraries = 'XXPay/Classes/**/*.a'
  
  # s.resource_bundles = {
  #   'XXPay' => ['XXPay/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'


 s.dependency 'Masonry'
 s.dependency 'XXNetwork'
 
 s.dependency 'AlipaySDK-iOS'
 s.dependency 'WechatOpenSDK' ,'1.8.5'
 
 #s.dependency 'DYSuperKit'
 #s.dependency 'DYFoundation'
 #s.dependency 'DYNetwork'
 #s.dependency 'DZNEmptyDataSet'
 #s.dependency 'YYText'



end
