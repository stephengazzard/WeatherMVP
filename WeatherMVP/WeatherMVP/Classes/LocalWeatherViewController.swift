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
    var weatherResponse: WeatherDayResponse?

    @IBOutlet var weatherCollectionView: UICollectionView!
    @IBOutlet var lastUpdatedLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

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
        weatherResponse = weather
        self.weatherCollectionView.reloadData()
    }

}

extension LocalWeatherViewController: UICollectionViewDataSource {

    struct Constants {
        static let WeatherCellReuseIdentifier = "WeatherCell"
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherResponse?.weatherRecords.count ?? 0
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return weatherCollectionView.dequeueReusableCellWithReuseIdentifier(Constants.WeatherCellReuseIdentifier, forIndexPath: indexPath)
    }

}
