//
//  WeatherService.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import Foundation

class InvalidNumberOfDaysError: ErrorType {}

class WeatherService {

    private let remoteService: RemoteService
    private let APIKey = "bb2b2312235500c5d0f419445c2c699b"

    init(remoteService: RemoteService) {
        self.remoteService = remoteService
    }

    func fetchWeatherForecast(forCity city: String, numberOfRecords: Int = 16, success: ([WeatherDayRecord]) -> (Void), failure: (ErrorType) -> (Void)) {
        guard numberOfRecords >= 1 && numberOfRecords <= 16 else {
            failure(InvalidNumberOfDaysError())
            return
        }

        let url = "api.openweathermap.org/data/2.5/forecast/daily?q=\(city)&mode=json&units=metric&cnt=\(numberOfRecords)&APPID=\(APIKey)"
        self.remoteService.getJSONFromURL(url, success: { (result: [[String: AnyObject]]) in
            NSLog("Got json: result")
        }, failure: { (error) in
            NSLog("Got error: error")
        })
    }

}
