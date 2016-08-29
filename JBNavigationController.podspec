Pod::Spec.new do |s|
  s.name         = "JBNavigationController"
  s.version      = "1.0.0"
  s.summary      = "Navigation controller with custom card-like animations with forwards and backwards swipe support"
  s.description  = <<-DESC
                   Navigation controller with custom card-like animations with forwards and backwards swipe support
                   DESC

  s.homepage     = "http://github.com/JakeBent/JBNavigationController"
  s.license      = "zlib"
  s.author       = { "Jake Benton" => "jacob.a.benton@gmail.com" }
  s.platform     = :ios
  s.source     = { :git => 'git@github.com:JakeBent/JBNavigationController.git', :tag => s.version.to_s}  
  s.source_files  = "JBNavigationController/Source/**/*"
end
