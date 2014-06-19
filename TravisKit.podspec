Pod::Spec.new do |s|
  s.name         = "TravisKit"
  s.version      = "1.0.0"
  s.summary      = "Travis CI iOS/OS X API Wrapper"
  s.homepage     = "https://github.com/legoless/TravisKit"
  s.license      = 'MIT'
  s.authors      = { "Dal Rupnik" => "legoless@gmail.com" }
  s.source       = { :git => "https://github.com/legoless/TravisKit.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '7.0'
  s.source_files = "TravisKit/*.{h,m}"
  s.frameworks   = 'Foundation', 'UIKit', 'CoreGraphics'
  s.requires_arc = true
  s.dependencies = ['AFNetworking', 'JSONModel']
  
  s.subspec 'Base' do |ss|
    ss.source_files = "TravisKit/*.{h,m}"
    ss.dependencies = ['AFNetworking', 'JSONModel']
  end
  
  s.subspec 'Log' do |ss|
    ss.source_files = "Log/*.{h,m}"
    ss.dependencies = ['libPusher']
  end
end