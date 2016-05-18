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
