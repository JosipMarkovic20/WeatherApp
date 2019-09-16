// MARK: - Mocks generated from file: WeatherApp/Networking/PlaceNameRepository.swift at 2019-09-16 10:01:03 +0000

//
//  PlaceNameRepository.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.

import Cuckoo
@testable import WeatherApp

import Alamofire
import Foundation
import RxSwift


 class MockPlaceNameRepository: PlaceNameRepository, Cuckoo.ClassMock {
    
     typealias MocksType = PlaceNameRepository
    
     typealias Stubbing = __StubbingProxy_PlaceNameRepository
     typealias Verification = __VerificationProxy_PlaceNameRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: PlaceNameRepository?

     func enableDefaultImplementation(_ stub: PlaceNameRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getPlace(name: String) -> Observable<PlaceData> {
        
    return cuckoo_manager.call("getPlace(name: String) -> Observable<PlaceData>",
            parameters: (name),
            escapingParameters: (name),
            superclassCall:
                
                super.getPlace(name: name)
                ,
            defaultCall: __defaultImplStub!.getPlace(name: name))
        
    }
    

	 struct __StubbingProxy_PlaceNameRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getPlace<M1: Cuckoo.Matchable>(name: M1) -> Cuckoo.ClassStubFunction<(String), Observable<PlaceData>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: name) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlaceNameRepository.self, method: "getPlace(name: String) -> Observable<PlaceData>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_PlaceNameRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getPlace<M1: Cuckoo.Matchable>(name: M1) -> Cuckoo.__DoNotUse<(String), Observable<PlaceData>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: name) { $0 }]
	        return cuckoo_manager.verify("getPlace(name: String) -> Observable<PlaceData>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class PlaceNameRepositoryStub: PlaceNameRepository {
    

    

    
     override func getPlace(name: String) -> Observable<PlaceData>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<PlaceData>).self)
    }
    
}


// MARK: - Mocks generated from file: WeatherApp/Networking/WeatherRepository.swift at 2019-09-16 10:01:03 +0000

//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.

import Cuckoo
@testable import WeatherApp

import Alamofire
import Foundation
import RxSwift


 class MockWeatherRepository: WeatherRepository, Cuckoo.ClassMock {
    
     typealias MocksType = WeatherRepository
    
     typealias Stubbing = __StubbingProxy_WeatherRepository
     typealias Verification = __VerificationProxy_WeatherRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: WeatherRepository?

     func enableDefaultImplementation(_ stub: WeatherRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getWeather(lng: Double, lat: Double) -> Observable<Weather> {
        
    return cuckoo_manager.call("getWeather(lng: Double, lat: Double) -> Observable<Weather>",
            parameters: (lng, lat),
            escapingParameters: (lng, lat),
            superclassCall:
                
                super.getWeather(lng: lng, lat: lat)
                ,
            defaultCall: __defaultImplStub!.getWeather(lng: lng, lat: lat))
        
    }
    

	 struct __StubbingProxy_WeatherRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getWeather<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(lng: M1, lat: M2) -> Cuckoo.ClassStubFunction<(Double, Double), Observable<Weather>> where M1.MatchedType == Double, M2.MatchedType == Double {
	        let matchers: [Cuckoo.ParameterMatcher<(Double, Double)>] = [wrap(matchable: lng) { $0.0 }, wrap(matchable: lat) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWeatherRepository.self, method: "getWeather(lng: Double, lat: Double) -> Observable<Weather>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WeatherRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getWeather<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(lng: M1, lat: M2) -> Cuckoo.__DoNotUse<(Double, Double), Observable<Weather>> where M1.MatchedType == Double, M2.MatchedType == Double {
	        let matchers: [Cuckoo.ParameterMatcher<(Double, Double)>] = [wrap(matchable: lng) { $0.0 }, wrap(matchable: lat) { $0.1 }]
	        return cuckoo_manager.verify("getWeather(lng: Double, lat: Double) -> Observable<Weather>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WeatherRepositoryStub: WeatherRepository {
    

    

    
     override func getWeather(lng: Double, lat: Double) -> Observable<Weather>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Weather>).self)
    }
    
}

