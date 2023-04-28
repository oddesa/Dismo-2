# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
workspace 'Dismo 2.xcworkspace'
project 'Dismo 2.xcodeproj'

def shared_pod
  pod 'Shared', :path => 'ModularizedModules/Shared'
end

def movie_reviews_pod
  pod 'MovieReviews', :path => 'ModularizedModules/MovieReviews'
end

def movie_collections_pod
  pod 'MovieCollections', :path => 'ModularizedModules/MovieCollections'
end

def movie_details_pod
  pod 'MovieDetails', :path => 'ModularizedModules/MovieDetails'
end

def movie_discover_pod
  pod 'MovieDiscover', :path => 'ModularizedModules/MovieDiscover'
end

target 'Dismo 2' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

#    pod 'Moya'
#    pod 'Kingfisher'
#    pod 'netfox'
  shared_pod
  movie_reviews_pod
  movie_collections_pod
  movie_details_pod
  movie_discover_pod
end

target 'MovieReviews_Example' do
  use_frameworks!
  project'ModularizedModules/MovieReviews/Example/MovieReviews.xcodeproj'
  
  shared_pod
  movie_reviews_pod
end

target 'MovieCollections_Example' do
  use_frameworks!
  project'ModularizedModules/MovieCollections/Example/MovieCollections.xcodeproj'
  
  shared_pod
  movie_collections_pod
end

target 'MovieDetails_Example' do
  use_frameworks!
  project'ModularizedModules/MovieDetails/Example/MovieDetails.xcodeproj'
  
  shared_pod
  movie_details_pod
end

target 'MovieDiscover_Example' do
  use_frameworks!
  project'ModularizedModules/MovieDiscover/Example/MovieDiscover.xcodeproj'
  
  shared_pod
  movie_discover_pod
end

