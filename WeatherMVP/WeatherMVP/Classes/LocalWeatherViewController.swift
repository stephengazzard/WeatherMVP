//
//  LocalWeatherViewController.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-17.
//  Copyright © 2016 TUI. All rights reserved.
//

import UIKit


class UpdatedAtDateFormatter {

    class func format(input: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        let formattedDate = dateFormatter.stringFromDate(input)
        return "Updated at \(formattedDate)"
    }

}

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

    struct Constants {
        static let LoadingMessage = "Loading"
        static private let WeatherCellReuseIdentifier = "WeatherCell"
    }

    func setWeatherLoadState(loadState: LoadState) {
        switch loadState {
        case .Loading:
            activityIndicator.startAnimating()
            lastUpdatedLabel.text = LocalWeatherViewController.Constants.LoadingMessage
        case .Loaded:
            activityIndicator.stopAnimating()
            if let weatherResponse = weatherResponse {
                lastUpdatedLabel.text = UpdatedAtDateFormatter.format(weatherResponse.updatedTimeStamp)
            } else {
                lastUpdatedLabel.text = ""
            }
        case .LoadFailed(let failureReason):
            activityIndicator.stopAnimating()
            lastUpdatedLabel.text = failureReason
        }

    }

    func setWeatherData(weather: WeatherDayResponse?) {
        weatherResponse = weather
        weatherCollectionView.reloadData()
    }

}

extension LocalWeatherViewController: UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherResponse?.weatherRecords.count ?? 0
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let
            weatherRecord = weatherResponse?.weatherRecords[indexPath.row],
            weatherCell = weatherCollectionView.dequeueReusableCellWithReuseIdentifier(Constants.WeatherCellReuseIdentifier, forIndexPath: indexPath) as? WeatherCollectionViewCell
        else { return UICollectionViewCell() }

        weatherCell.highWeatherLabel.text = "\(weatherRecord.maxTemperature)ºC"
        weatherCell.lowWeatherLabel.text = "\(weatherRecord.minTemperature)ºC"

        return weatherCell
    }

}
