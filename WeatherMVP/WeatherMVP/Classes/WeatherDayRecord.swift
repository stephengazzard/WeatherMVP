//
//  WeatherDayRecord.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import Foundation

class WeatherDayResponse {

    let updatedTimeStamp: NSDate
    let weatherRecords: [WeatherDayRecord]

    required init(weatherRecords: [WeatherDayRecord], updatedTimeStamp: NSDate = NSDate()) {
        self.updatedTimeStamp = updatedTimeStamp
        self.weatherRecords = weatherRecords
    }
}

extension WeatherDayResponse: JSONMappable {

    class func createFromJSONDictionary(JSONDictionary: [String: AnyObject]) throws -> Self {
        guard let weatherRecordJSON = JSONDictionary["list"] as? [[String: AnyObject]] else {
            throw InvalidDataError()
        }
        let weatherRecords = try WeatherDayRecord.createFromJSONArray(weatherRecordJSON)
        return self.init(weatherRecords: weatherRecords)
    }

}

class WeatherDayRecord {

    let minTemperature: Double
    let maxTemperature: Double

    required init(minTemperature: Double, maxTemperature: Double) {
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
    }
}

extension WeatherDayRecord: JSONMappable {

    class func createFromJSONDictionary(JSONDictionary: [String: AnyObject]) throws -> Self {

        guard let
            temperatureDictionary = JSONDictionary["temp"] as? [String: AnyObject],
            minTemperature = temperatureDictionary["min"] as? Double,
            maxTemperature = temperatureDictionary["max"] as? Double
        else { throw InvalidDataError() }

        return self.init(minTemperature: minTemperature, maxTemperature: maxTemperature)
    }

}
