#
# Be sure to run `pod lib lint AHCategoryView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AHCategoryView'
  s.version          = '1.0.0'
  s.summary          = 'AHCategoryView.'

  s.description      = <<-DESC
A typical top navigation view
                       DESC

  s.homepage         = 'https://github.com/ivsall2012/AHCategoryView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ivsall2012' => 'ivsall2012@gmail.com' }
  s.source           = { :git => 'https://github.com/ivsall2012/AHCategoryView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'AHCategoryView/Classes/**/*'

end
