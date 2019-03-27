Pod::Spec.new do |spec|
  spec.name                     = "Pathos"
  spec.version                  = "0.1.2"
  spec.summary                  = "A file management library for Swift"
  spec.homepage                 = "https://github.com/dduan/Pathos"
  spec.license                  = { :type => "MIT", :file => "LICENSE.md" }
  spec.author                   = { "Daniel Duan" => "daniel@duan.ca" }
  spec.social_media_url         = "https://twitter.com/daniel_duan"
  spec.platform                 = :osx, '10.9'
  spec.swift_version            = '5.0'
  spec.source                   = { :git => "https://github.com/dduan/Pathos.git", :tag => "#{spec.version}" }
  spec.source_files             = "Sources/**/*.swift"
  spec.requires_arc             = true
  spec.module_name              = "Pathos"
end
