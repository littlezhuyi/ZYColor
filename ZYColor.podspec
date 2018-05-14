Pod::Spec.new do |s|

  s.name         = "ZYColor"
  s.version      = "0.0.1"
  s.summary      = "简单的测试"   # 简短介绍
  s.description  = <<-DESC
                  私有测试，他们说要长一些，再长一些
                   DESC
  s.homepage     = "https://github.com/littlezhuyi"
  s.license      = "MIT"
  s.author             = { "朱逸" => "18749618826@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/littlezhuyi/ZYColor.git", :tag => s.version }
  s.source_files  = "ZYColor/**/*.{h,m}"
  s.requires_arc = true
end