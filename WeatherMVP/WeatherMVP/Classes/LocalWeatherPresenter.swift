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

    init(view: LocalWeatherView, wireframe: WeatherWireframe) {
        self.view = view
        self.wireframe = wireframe
    }

}
