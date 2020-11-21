Pod::Spec.new do |s|
  s.name                  = 'DeepLinking'
  s.version               = '1.0.0'
  s.summary               = 'A simple way to add custom DeepLinks support to the Swift app'
  s.homepage              = 'https://github.com/SkafferTeam/DeepLinking'
  s.license               = { type: 'MIT', file: 'LICENSE' }
  s.author                = { 'Egor Iskrenkov' => 'e.iskrenkov@gmail.com' }
  s.source                = { git: 'https://github.com/SkafferTeam/DeepLinking.git', tag: s.version.to_s }
  s.social_media_url      = 'https://twitter.com/skaffer_app'

  s.ios.deployment_target = '10.0'
  s.swift_version         = '5.0'
  s.source_files          = 'Sources/*.swift'
end
