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
            var viewModel: MainScreenViewModelProtocol!
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
                var loaderObserver: TestableObserver<Bool>!
                
                beforeEach {
                    testScheduler = TestScheduler(initialClock: 1)
                    viewModel = MainScreenViewModel(weatherRepository: mockWeatherRepository, subscribeScheduler: testScheduler)
                    viewModel.collectAndPrepareData(for: viewModel.getWeatherDataSubject).disposed(by: disposeBag)
                    loaderObserver = testScheduler.createObserver(Bool.self)
                    viewModel.loaderSubject.subscribe(loaderObserver).disposed(by: disposeBag)
                }
                
                it("Testing current weather object"){
                    testScheduler.start()
                    viewModel.getWeatherDataSubject.onNext([0,0])
                    expect(viewModel.weatherResponse).toNot(beNil())
                    expect(viewModel.weatherResponse?.currently).toNot(beNil())
                    expect(viewModel.weatherResponse?.currently.humidity).toNot(beNil())
                    expect(viewModel.weatherResponse?.currently.icon).toNot(beNil())
                    expect(viewModel.weatherResponse?.currently.pressure).toNot(beNil())
                    expect(viewModel.weatherResponse?.currently.summary).toNot(beNil())
                    expect(viewModel.weatherResponse?.currently.temperature).toNot(beNil())
                    expect(viewModel.weatherResponse?.currently.time).toNot(beNil())
                    expect(viewModel.weatherResponse?.currently.windSpeed).toNot(beNil())
                }
                
                it("Testing daily weather object"){
                    testScheduler.start()
                    viewModel.getWeatherDataSubject.onNext([0,0])
                    expect(viewModel.weatherResponse).toNot(beNil())
                    expect(viewModel.weatherResponse?.daily).toNot(beNil())
                    expect(viewModel.weatherResponse?.daily.data.isEmpty).to(beFalse())
                    for daily in (viewModel.weatherResponse?.daily.data)!{
                        expect(daily.temperatureMax).toNot(beNil())
                        expect(daily.temperatureMin).toNot(beNil())
                        expect(daily.time).toNot(beNil())
                    }
                }
                
                it("Testing loader"){
                    testScheduler.start()
                    viewModel.getWeatherDataSubject.onNext([0,0])
                    expect(loaderObserver.events.count).toEventually(equal(2))
                    expect(loaderObserver.events[0].value.element).to(beTrue())
                    expect(loaderObserver.events[1].value.element).to(beFalse())
                }
                
            }
        }
    }
}
