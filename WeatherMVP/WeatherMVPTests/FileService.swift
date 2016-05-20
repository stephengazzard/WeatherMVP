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

    var mockFileName: String?

    func getDataFromURL(url: String, success: (NSData) -> (Void), failure: (ErrorType) -> (Void)) {
        NSLog("Get data from \(url)")

        //Mimic asynchronicity
        dispatch_after(NSEC_PER_SEC * 1, dispatch_get_main_queue()) {
            guard let
                mappedFileName = self.mockFileName,
                mappedFilePath = NSBundle(forClass: self.dynamicType).pathForResource(mappedFileName, ofType: nil),
                fileData = NSData(contentsOfFile: mappedFilePath)
                else {
                    failure(MissingTestDataError())
                    return
            }
            
            success(fileData)
        }
    }

}
