source 'https://gitee.com/TheAcery/ACRepos.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.0'
inhibit_all_warnings!
use_modular_headers!

target 'BaWangBieJICash' do
#  use_frameworks!
  
#  pod 'ACAutoCode'
#  pod 'ACModelTool'
  pod 'AFNetworking', :git => 'https://github.com/crasowas/AFNetworking.git'
  pod 'YYKit', :git => 'https://gitee.com/TheAcery/YYKitForAcery.git', :branch => 'master'
  pod 'FBSDKCoreKit','~> 18.0.0'
  
  pod 'JXCategoryView','1.5.9'
  pod 'IQKeyboardManager'
  
  pod 'XYUUID'
  pod 'SAMKeychain'
  
  pod 'MBProgressHUD',:git => 'https://github.com/jdg/MBProgressHUD.git'
  pod 'FDFullscreenPopGesture'
  pod 'LYEmptyView'
  pod 'MJRefresh'
  pod 'Masonry'
  pod 'SDWebImage'
  
  post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
              config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"

              # 编译包体大小优化设置
              config.build_settings['LLVM_LTO'] = 'YES_THIN' if config.name == 'Release'
              config.build_settings['GCC_GENERATE_DEBUGGING_SYMBOLS'] = 'No' if config.name == 'Release'
              config.build_settings['GCC_OPTIMIZATION_LEVEL'] = 'z' if config.name == 'Release'
              
         end
      end
    end
  end
end
