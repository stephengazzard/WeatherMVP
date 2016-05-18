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
        case (.LoadFailed(let reason1), .LoadFailed(let reason2)): return reason1 == reason2
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

    private let weatherCache: WeatherCache
    private let weatherService: WeatherService

    init(view: LocalWeatherView, wireframe: WeatherWireframe, weatherCache: WeatherCache, weatherService: WeatherService) {
        self.view = view
        self.wireframe = wireframe
        self.weatherCache = weatherCache
        self.weatherService = weatherService
    }

    //One downside to this pattern is that the presenter is still, to a small degree, tied to the lifecycle of the view, so some things make more sense to wait until viewDidLoad is called.
    func viewDidLoad() {
        view.setWeatherData(self.weatherCache.lastWeatherResponse)
        if self.weatherCache.lastWeatherResponse != nil {
            view.setWeatherLoadState(.Loaded)
        } else {
            self.reloadWeatherData()
        }
    }

    func reloadWeatherData() {
        view.setWeatherLoadState(.Loading)
    }


}
