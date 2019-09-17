 platform :ios, '10.0'

target 'WeatherApp' do
  use_frameworks!

pod 'Alamofire'
pod 'RealmSwift'
pod 'RxSwift'
pod 'RxCocoa'
pod 'Hue'
pod 'SwiftLocation'

def testing_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'Cuckoo'
    pod 'RxTest'
end

target 'WeatherAppTests' do
    inherit! :search_paths
    testing_pods
end


end