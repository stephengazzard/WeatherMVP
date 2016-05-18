//
//  SelectWeatherViewController.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-17.
//  Copyright © 2016 TUI. All rights reserved.
//

import UIKit

class SelectWeatherViewController: UIViewController, SelectWeatherView {

    var presenter: SelectWeatherPresenter?

    //MARK: - Actions

    @IBAction func selectLocalWeather() {
        self.presenter?.showLocalWeather()
    }

}
