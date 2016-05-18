//
//  JSONMappable.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import Foundation

protocol JSONMappable {

    /// Maps a dictionary to a new object, if it contains all valid keys
    static func createFromJSONDictionary(JSONDictionary: [String: AnyObject]) throws -> Self
}

extension JSONMappable {
    /// Creates an array of objects using the dictionary mapping
    static func createFromJSONArray(JSONArray: [[String: AnyObject]]) throws -> [Self] {
        var result: [Self] = []
        for JSONDictionary in JSONArray {
            result.append(try Self.createFromJSONDictionary(JSONDictionary))
        }
        return result
    }

}
