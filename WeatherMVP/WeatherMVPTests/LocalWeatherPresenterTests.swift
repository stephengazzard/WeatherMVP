//
//  WeatherPresenterTests.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import Quick
import Nimble
@testable import WeatherMVP

class LocalWeatherPresenterTests: QuickSpec {
    
    override func spec() {
        var mockView: MockLocalWeatherView!
        var mockCache: MockWeatherCache!
        var mockRemoteService: FileService!
        var weatherService: WeatherService!
        var subject: LocalWeatherPresenter!

        beforeEach {
            mockView = MockLocalWeatherView()
            mockCache = MockWeatherCache()
            mockRemoteService = FileService()
            weatherService = WeatherService(remoteService: mockRemoteService)
            subject = LocalWeatherPresenter(view: mockView, wireframe: WeatherWireframe()!, weatherCache: mockCache, weatherService: weatherService)
        }

        describe(".viewDidLoad") {
            context("when there is a weather record in the cache") {
                beforeEach {
                    mockCache.lastWeatherResponse = WeatherDayResponse(weatherRecords: [])
                    subject.viewDidLoad()
                }

                it("sets a weather record on the view") {
                    expect(mockView.weatherData).toNot(beNil())
                }

                it("sets the views loading state to .Loaded") {
                    expect(mockView.loadState).to(equal(LoadState.Loaded))
                }
            }

            context("when the weather cache is empty") {
                beforeEach {
                    mockCache.lastWeatherResponse = nil
                    subject.viewDidLoad()
                }

                it("sets no weather record on the view") {
                    expect(mockView.weatherData).to(beNil())
                }

                it("sets the views loading state to .Loading") {
                    expect(mockView.loadState).to(equal(LoadState.Loading))
                }
            }
        }

        describe("When reloading the weather") {
            var oldWeatherRecord: WeatherDayResponse!
            beforeEach {
                oldWeatherRecord = WeatherDayResponse(weatherRecords: [])
                mockView.weatherData = oldWeatherRecord
                mockCache.lastWeatherResponse = oldWeatherRecord
            }
            it("sets the loading state of the view to .Loading") {
                expect(mockView.loadState).to(equal(LoadState.Loading))
            }
            context("and it succeeds") {
                beforeEach {
                    mockRemoteService.mockFileName = "dailyWeatherResponse.json"
                    subject.reloadWeatherData()
                }
                it("sets the state of the view to .Loading") {
                    expect(mockView.loadState).to(equal(LoadState.Loading))
                }
                it("eventually sets the state of the view to .Loaded") {
                    expect(mockView.loadState).toEventually(equal(LoadState.Loaded))
                }
                it("the weather object the view is showing is eventually the new object") {
                    expect(mockView.weatherData).toEventuallyNot(be(oldWeatherRecord))
                }
                it("the cache eventually stores the new weather object") {
                    expect(mockCache.lastWeatherResponse).toEventuallyNot(be(oldWeatherRecord))
                }
            }
            context("and it fails") {
                beforeEach {
                    mockRemoteService.mockFileName = "validJSON.json"
                    subject.reloadWeatherData()
                }
                it("eventually sets the state of the view to .LoadFailed") {
                    expect(mockView.loadState).toEventually(equal(LoadState.LoadFailed(reason: "")))
                }
                it("the view continues to show the last successful weather response") {
                    expect(mockView.weatherData).toEventually(be(oldWeatherRecord))
                }
                it("the cache continues to hold the last downloaded weather response") {
                    expect(mockCache.lastWeatherResponse).toEventually(be(oldWeatherRecord))
                }
            }
        }
    }

}

class MockLocalWeatherView: LocalWeatherView {

    var loadState: LoadState = .Loading
    var weatherData: WeatherDayResponse?

    func setWeatherLoadState(loadState: LoadState) {
        self.loadState = loadState
    }

    func setWeatherData(weather: WeatherDayResponse?) {
        self.weatherData = weather
    }
}

class MockWeatherCache: WeatherCache {

    var lastWeatherResponse: WeatherDayResponse?

}
