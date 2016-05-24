//
//  WeatherDayRecord.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import Foundation

@objc class WeatherDayResponse : NSObject, NSCoding {

    let updatedTimeStamp: NSDate
    let weatherRecords: [WeatherDayRecord]

    required init(weatherRecords: [WeatherDayRecord], updatedTimeStamp: NSDate = NSDate()) {
        self.updatedTimeStamp = updatedTimeStamp
        self.weatherRecords = weatherRecords
    }

    //MARK: - NSCoding
    private struct EncodingKeys {
        static let updatedTimeStamp = "updatedTimeStamp"
        static let weatherRecords = "weatherRecords"
    }

    required init?(coder aDecoder: NSCoder) {
        guard let
            timestamp = aDecoder.decodeObjectForKey(EncodingKeys.updatedTimeStamp) as? NSDate,
            weatherRecords = aDecoder.decodeObjectForKey(EncodingKeys.weatherRecords) as? [WeatherDayRecord]
        else { return nil }

        self.updatedTimeStamp = timestamp
        self.weatherRecords = weatherRecords
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(updatedTimeStamp, forKey: EncodingKeys.updatedTimeStamp)
        aCoder.encodeObject(weatherRecords, forKey: EncodingKeys.weatherRecords)
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


@objc class WeatherDayRecord: NSObject, NSCoding {

    let minTemperature: Double
    let maxTemperature: Double

    required init(minTemperature: Double, maxTemperature: Double) {
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
    }

    //MARK: - NSCoding
    private struct EncodingKeys {
        static let minTemperature = "minTemperature"
        static let maxTemperature = "maxTemperature"
    }

    required init?(coder aDecoder: NSCoder) {
        self.minTemperature = aDecoder.decodeDoubleForKey(EncodingKeys.minTemperature)
        self.maxTemperature = aDecoder.decodeDoubleForKey(EncodingKeys.maxTemperature)
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeDouble(minTemperature, forKey: EncodingKeys.minTemperature)
        aCoder.encodeDouble(maxTemperature, forKey: EncodingKeys.maxTemperature)
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
