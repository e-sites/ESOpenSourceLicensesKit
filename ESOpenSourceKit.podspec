Pod::Spec.new do |s|
  s.name           = "ESOpenSourceKit"
  s.version        = "1.3.1"
  s.platform       = :ios, "8.0"
  s.summary        = "A bash script to generate an HTML file of all the license files used with your CocoaPods Project"
  s.author         = { "Bas van Kuijck" => "bas@e-sites.nl" }
  s.license        = { :type => "MIT", :file => "LICENSE" }
  s.homepage       = "https://github.com/e-sites/#{s.name}"
  s.source         = { :git => "https://github.com/e-sites/#{s.name}.git", :tag => s.version.to_s }
  s.screenshot     = "https://raw.githubusercontent.com/e-sites/#{s.name}/master/Assets/example.gif"

  s.requires_arc   = true
  s.frameworks    = 'UIKit', 'Foundation'

  s.default_subspec = 'Swift'

  s.subspec 'Core' do |sp|
    sp.preserve_paths = "#{s.name}/Scripts/*.*"
    sp.resource_bundles = { 'ESOpenSourceKit' => [ 'ESOpenSourceKit/Resources/opensource-licenses.html' ] }
  end

  s.subspec 'Swift' do |sp|
    sp.dependency 'ESOpenSourceKit/Core'
    sp.source_files  = "#{s.name}/Classes/*.{swift}"
  end
end
