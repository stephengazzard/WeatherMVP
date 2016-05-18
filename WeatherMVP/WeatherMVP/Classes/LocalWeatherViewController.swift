//
//  LocalWeatherViewController.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-17.
//  Copyright © 2016 TUI. All rights reserved.
//

import UIKit



class LocalWeatherViewController: UIViewController {

    var presenter: LocalWeatherPresenter?

    override func viewDidLoad() {
        presenter?.viewDidLoad()
        super.viewDidLoad()
    }

}

extension LocalWeatherViewController: LocalWeatherView {

    func setWeatherLoadState(loadState: LoadState) {
        //TODO: Update
    }

    func setWeatherData(weather: WeatherDayResponse?) {
        //TODO: Update
    }

}
