//
//  WeatherCache.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import UIKit

class WeatherCache {

    private var filePath: String

    var lastWeatherResponse: WeatherDayResponse? {
        didSet {
            guard let lastWeatherResponse = lastWeatherResponse else { return }
            NSKeyedArchiver.archiveRootObject(lastWeatherResponse, toFile: self.filePath)
        }
    }

    required init(fileName: String = "weather.cache") {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        self.filePath = "\(documentsPath)/\(fileName)"

        if NSFileManager.defaultManager().fileExistsAtPath(self.filePath),
            let data = NSData(contentsOfFile: self.filePath),
            let weatherResponse = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? WeatherDayResponse {
            lastWeatherResponse = weatherResponse
        }
    }

}
