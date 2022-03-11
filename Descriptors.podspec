Pod::Spec.new do |spec|
  spec.name = "Descriptors"
  spec.version = "0.2.0"
  spec.summary = "A set of descriptors for TextureSwiftSupport, CompositionKit"
  spec.description = <<-DESC
  A set of descriptors for TextureSwiftSupport and CompositionKit
                   DESC

  spec.homepage = "https://github.com/muukii/Descriptors"
  spec.license = "MIT"
  spec.author = { "Muukii" => "muukii.app@gmail.com" }
  spec.social_media_url = "https://twitter.com/muukii_app"

  spec.ios.deployment_target = "10.0"

  spec.source = { :git => "https://github.com/muukii/Descriptors.git", :tag => "#{spec.version}" }
  spec.framework = "UIKit"
  spec.requires_arc = true
  spec.swift_versions = ["5.3", "5.4", "5.5"]

  spec.default_subspecs = ["Core"]

  spec.subspec "Core" do |ss|
    ss.source_files = "Sources/Descriptors/**/*.swift"
  end
end
