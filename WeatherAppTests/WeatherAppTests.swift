//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Josip Marković on 10/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

@testable import WeatherApp
import Cuckoo
import Quick
import Nimble
import RxSwift
import RxTest
import RxSwift

class MainScreenViewModelTests: QuickSpec {
    
    
    
    override func spec(){
        
        
        describe("Data initialization"){
            
            let mockWeatherRepository = MockWeatherRepository()
            var viewModel: MainScreenViewModelProtocol
            var testScheduler: TestScheduler!
            let disposeBag = DisposeBag()
            
            
            beforeSuite {
                Cuckoo.stub(mockWeatherRepository){ mock in
                    let testBundle = Bundle(for: MainScreenViewModelTests.self)
                    let responseURL = testBundle.url(forResource: "WeatherResponse", withExtension: "json")!
                    let responseData = try! Data(contentsOf: responseURL)
                    let parsedData = try! JSONDecoder().decode(Weather.self, from: responseData)
                    when(mock.getWeather(lng: any(), lat: any())).thenReturn(Observable.just(parsedData))
                }
            }
            
            context("Testing received data"){
                beforeEach {
                    testScheduler = TestScheduler(initialClock: 1)
                    viewModel = MainScreenViewModel(weatherRepository: mockWeatherRepository, subscribeScheduler: testScheduler)
                    viewModel.collectAndPrepareData(for: viewModel.getWeatherDataSubject).disposed(by: disposeBag)
                }
                
                
            }
            
            
            
        }
        
        
    }
    
    
    
}
