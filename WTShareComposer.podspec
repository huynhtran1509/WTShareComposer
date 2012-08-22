Pod::Spec.new do |s|
  s.name         = "WTShareComposer"
  s.version      = "0.0.1"
  s.summary      = "A generic share compose view controller"
  s.homepage     = "https://github.com/willowtreeapps/WTShareComposer"
  s.license      = '???'
  s.author       = { "Joel Garrett" => "joel.garrett@willowtreeapps.com" }
  s.source       = { :git => "http://github.com/willowtreeapps/WTShareComposer.git", :tag => "0.0.1" }
  s.source_files = 'WTShareComposer', 'WTShareComposer/*.{h,m}'
  s.resource     = 'DETweetComposeViewController/Resources/*.png'
  s.requires_arc = true
end
