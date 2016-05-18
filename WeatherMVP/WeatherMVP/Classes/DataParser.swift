//
//  DataParser.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import UIKit

protocol DataParser {

    func parseData<ResultType>(data: NSData) throws -> ResultType

}

class InvalidDataError: ErrorType { }

typealias JSONDictionary = [String: AnyObject]
typealias JSONArray = [JSONDictionary]

class JSONDataParser: DataParser {

    func parseData<ResultType>(data: NSData) throws -> ResultType {
        guard let result = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? ResultType else {
            throw InvalidDataError()
        }
        return result
    }

}

