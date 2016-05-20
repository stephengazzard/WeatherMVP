//
//  LocalWeatherPresenter.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-17.
//  Copyright © 2016 TUI. All rights reserved.
//

import UIKit

enum LoadState : Equatable {
    case Loading
    case Loaded
    case LoadFailed(reason: String)
}


func ==(lhs: LoadState, rhs: LoadState)->Bool {
    switch (lhs, rhs) {
        case (.Loading, .Loading): return true
        case (.Loaded, .Loaded): return true
        case (.LoadFailed, .LoadFailed): return true
        default: return false
    }
}

protocol LocalWeatherView {

    func setWeatherLoadState(loadState: LoadState)
    func setWeatherData(weather: WeatherDayResponse?)

}

class LocalWeatherPresenter {

    private let view: LocalWeatherView
    private let wireframe: WeatherWireframe

    private var weatherCache: WeatherCache
    private let weatherService: WeatherService

    private var weatherFetchInProgress = false

    init(view: LocalWeatherView, wireframe: WeatherWireframe, weatherCache: WeatherCache, weatherService: WeatherService) {
        self.view = view
        self.wireframe = wireframe
        self.weatherCache = weatherCache
        self.weatherService = weatherService
    }

    //One downside to this pattern is that the presenter is still, to a small degree, tied to the lifecycle of the view, so some things make more sense to wait until viewDidLoad is called.
    func viewDidLoad() {
        view.setWeatherData(weatherCache.lastWeatherResponse)
        if weatherCache.lastWeatherResponse != nil {
            view.setWeatherLoadState(.Loaded)
        } else {
            reloadWeatherData()
        }
    }

    func reloadWeatherData() {
        if weatherFetchInProgress { return }

        view.setWeatherLoadState(.Loading)
        weatherFetchInProgress = true

        self.weatherService.fetchWeatherForecast(forCity: "London", success: { (response) in
            self.view.setWeatherData(response)
            self.view.setWeatherLoadState(.Loaded)
            self.weatherCache.lastWeatherResponse = response
            self.weatherFetchInProgress = false
        }, failure: { (error) in
            self.view.setWeatherLoadState(.LoadFailed(reason: "Could not load weather"))
            self.weatherFetchInProgress = false
        })
    }

}
