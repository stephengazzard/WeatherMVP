//
//  WeatherWireframe.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-17.
//  Copyright © 2016 TUI. All rights reserved.
//

import UIKit

class WeatherWireframe {

    let rootNavigationController: UINavigationController

    private let storyboard: UIStoryboard

    init?() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootNavigationController = storyboard.instantiateInitialViewController() as? UINavigationController else { return nil }

        self.rootNavigationController = rootNavigationController
        self.storyboard = storyboard
    }

    func showLandingPage() {
        let landingPage: SelectWeatherViewController = self.storyboard.instantiateViewControllerWithIdentifier("LandingPage")
        let landingPagePresenter = SelectWeatherPresenter(view: landingPage, wireframe: self)
        landingPage.presenter = landingPagePresenter

        self.rootNavigationController.viewControllers = [landingPage]
    }

    func showMyWeatherPage() {
        let myWeatherViewController: LocalWeatherViewController = self.storyboard.instantiateViewControllerWithIdentifier("MyWeather")
        let myWeatherPresenter = LocalWeatherPresenter(view: myWeatherViewController, wireframe: self)
        myWeatherViewController.presenter = myWeatherPresenter

        self.rootNavigationController.pushViewController(myWeatherViewController, animated: true)
    }

}
