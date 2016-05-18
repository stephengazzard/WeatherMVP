//
//  SelectWeatherPresenter.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-17.
//  Copyright © 2016 TUI. All rights reserved.
//

import UIKit

protocol SelectWeatherView {

}

class SelectWeatherPresenter {

    private let view: SelectWeatherView
    private let wireframe: WeatherWireframe

    init(view: SelectWeatherView, wireframe: WeatherWireframe) {
        self.view = view
        self.wireframe = wireframe
    }

    //MARK: - Responding to events

    func showLocalWeather() {
        self.wireframe.showMyWeatherPage()
    }

}
