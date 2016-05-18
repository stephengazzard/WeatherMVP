//
//  LocalWeatherPresenter.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-17.
//  Copyright © 2016 TUI. All rights reserved.
//

import UIKit

protocol LocalWeatherView {

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

    

}
