

Pod::Spec.new do |s|
  s.name             = 'XXPay'
  s.version          = '0.1.0'
  s.summary          = 'A short description of XXPay.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://git.zhcs.com/iOS_Group/XXPay'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Monster .' => 'wwwarehouse@163.com' }
  s.source           = { :git => 'http://git.zhcs.com/iOS_Group/XXPay.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'XXPay/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XXPay' => ['XXPay/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'


 s.dependency 'Masonry'
 s.dependency 'XXNetwork'
 
 #s.dependency 'DYSuperKit'
 #s.dependency 'DYFoundation'
 #s.dependency 'DYNetwork'
 #s.dependency 'DZNEmptyDataSet'
 #s.dependency 'YYText'



end
