//
//  SearchScreenViewModelTests.swift
//  WeatherAppTests
//
//  Created by Josip Marković on 13/09/2019.
//  Copyright © 2019 Josip Marković. All rights reserved.
//

@testable import WeatherApp
import Cuckoo
import Quick
import Nimble
import RxSwift
import RxTest
import RxSwift


class SearchScreenViewModelTests: QuickSpec{
    
    
    override func spec() {
        
        describe("Data initialization"){
            
            let mockPlaceRepository = MockPlaceNameRepository()
            var viewModel: SearchScreenProtocol!
            var testScheduler: TestScheduler!
            let disposeBag = DisposeBag()
            
            
            beforeSuite {
                Cuckoo.stub(mockPlaceRepository){ mock in
                    let testBundle = Bundle(for: MainScreenViewModelTests.self)
                    let responseURL = testBundle.url(forResource: "PlacesSearchResponse", withExtension: "json")!
                    let responseData = try! Data(contentsOf: responseURL)
                    let parsedData = try! JSONDecoder().decode(PlaceData.self, from: responseData)
                    when(mock.getPlace(name: any())).thenReturn(Observable.just(parsedData))
                }
            }
            
            context("Testing received data"){
                
                beforeEach {
                    testScheduler = TestScheduler(initialClock: 1)
                    viewModel = SearchScreenViewModel(placeRepository: mockPlaceRepository, subscribeScheduler: testScheduler)
                    viewModel.collectAndPrepareData(for: viewModel.getPlaceDataSubject).disposed(by: disposeBag)
                }
                
                
                it("Testing places array"){
                    testScheduler.start()
                    viewModel.getPlaceDataSubject.onNext("")
                    expect(viewModel.placeResponse.isEmpty).to(beFalse())
                }
                
                it("Testing places array elements"){
                    testScheduler.start()
                    viewModel.getPlaceDataSubject.onNext("")
                    for element in viewModel.placeResponse{
                        expect(element.lat).toNot(beNil())
                        expect(element.lng).toNot(beNil())
                        expect(element.name).toNot(beNil())
                    }
                }
                
            }
        }
    }
    
}

