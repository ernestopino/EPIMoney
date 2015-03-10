Pod::Spec.new do |s|
  s.name             = "EPIMoney"
  s.version          = "0.0.1"
  s.summary          = "EPIMoney is a simple component to work with currency and your corresponding amount."
  s.description      = <<-DESC
                       If you have to work with amount of money, currency based on locale... EPIMoney is for you. More info in advance !!!
                       DESC
  s.homepage         = "https://github.com/ernestopino/EPIMoney.git"

  s.license          = {
    :type => "MIT",
    :file => "LICENSE"
  }

  s.author           = {
    "Ernesto Pino" => "ernesto.pino@epinom.com"
  }

  s.source           = {
    :git => "https://github.com/ernestopino/EPIMoney.git",
    :tag => "0.0.1"
  }

  s.social_media_url = 'https://twitter.com/ernestopino'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'EPIMoney' => ['Pod/Assets/*.png']
  }

  s.requires_arc = true
end
