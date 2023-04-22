# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
workspace 'Dismo 2.xcworkspace'
project 'Dismo 2.xcodeproj'

def shared_pod
  pod 'Shared', :path => 'ModularizedModules/Shared'
end

target 'Dismo 2' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

#    pod 'Moya'
#    pod 'Kingfisher'
#    pod 'netfox'
  shared_pod
end

#target 'Shared_Example' do
#  use_frameworks!
##  project 'Dismo\ 2/ModularizedModules/Shared/Example/Shared.xcodeproj'
#  project 'ModularizedModules/Shared/Example/Shared.xcodeproj'
#
#  shared_pod
#end
