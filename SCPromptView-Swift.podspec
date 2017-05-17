Pod::Spec.new do |s|
  s.name         = 'SCPromptView-Swift'
  s.version      = '1.0'
  s.summary      = 'A prompt view which show in the top of the screen .'
  s.homepage     = 'https://github.com/Chan4iOS/SCPromptView-Swift'
  s.author       = "CT4 => 284766710@qq.com"
  s.source       = {:git => 'https://github.com/Chan4iOS/SCPromptView-Swift.git', :tag => "#{s.version}"}
  s.source_files = "SCPromptView-Swift/*.{h,m}"
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  s.license = 'MIT'
  s.pod_target_xcconfig =  {
  'SWIFT_VERSION' => '3.0',
  }

end
