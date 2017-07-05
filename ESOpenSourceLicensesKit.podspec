Pod::Spec.new do |s|
  s.name           = "ESOpenSourceLicensesKit"
  s.version        = "2.0"
  s.platform       = :ios, "9.0"
  s.summary        = "A script to generate an HTML file of all the license files used with your CocoaPods Project"
  s.author         = { "Bas van Kuijck" => "bas@e-sites.nl" }
  s.license        = { :type => "MIT", :file => "LICENSE" }
  s.homepage       = "https://github.com/e-sites/#{s.name}"
  s.source         = { :git => "https://github.com/e-sites/#{s.name}.git", :tag => s.version.to_s }
  s.screenshot     = "https://raw.githubusercontent.com/e-sites/#{s.name}/master/Assets/example.gif"

  s.requires_arc   = true
  s.frameworks    = 'UIKit', 'Foundation'

  s.preserve_paths = "#{s.name}/Scripts/*.*"
  s.resource_bundles = { 'ESOpenSourceLicensesKit' => [ 'ESOpenSourceLicensesKit/Resources/opensource-licenses.html' ] }

  s.source_files  = "#{s.name}/Classes/*.{swift}"
end
