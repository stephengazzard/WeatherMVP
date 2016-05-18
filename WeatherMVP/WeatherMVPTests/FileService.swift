//
//  FileService.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import Foundation
@testable import WeatherMVP

class MissingTestDataError: ErrorType {}

class FileService: RemoteService {

    var fileMapping: [String: String] = [:]

    func getDataFromURL(url: String, success: (NSData) -> (Void), failure: (ErrorType) -> (Void)) {
        NSLog("Get data from \(url)")

        guard let
            mappedFileName = fileMapping[url],
            mappedFilePath = NSBundle(forClass: self.dynamicType).pathForResource(mappedFileName, ofType: nil),
            fileData = NSData(contentsOfFile: mappedFilePath)
        else {
            failure(MissingTestDataError())
            return
        }

        success(fileData)
    }

}
