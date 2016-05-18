//
//  JSONTestHelper.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import UIKit

class TestHelper: NSObject {

    class func loadDataFromFileNamed(fileName: String, fileExtension: String) -> NSData {
        let filePath = NSBundle(forClass: self).pathForResource(fileName, ofType: fileExtension)
        return NSData(contentsOfFile: filePath!)!
    }

}
