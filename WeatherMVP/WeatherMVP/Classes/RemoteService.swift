//
//  RESTService.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import UIKit

protocol RemoteService {

    func getDataFromURL(url: String, success: (NSData) -> (Void), failure: (ErrorType) -> (Void))

}

extension RemoteService {

    func getObjectFromURL<ResultType>(url: String, parser: DataParser, success: (ResultType) -> (Void), failure: (ErrorType) -> (Void)) {
        self.getDataFromURL(url, success: { (data) in
            do {
                let response: ResultType = try parser.parseData(data)
                success(response)
            } catch {
                failure(error)
            }
        }, failure: failure)
    }

    func getJSONFromURL<ResultType>(url: String, success: (ResultType) -> (Void), failure: (ErrorType) -> (Void)) {
        self.getObjectFromURL(url, parser: JSONDataParser(), success: success, failure: failure)
    }

}

class InvalidURLError: ErrorType {}
class UnexpectedError: ErrorType {}
class NoDataError: ErrorType {}

class InvalidResponseError: ErrorType {
    let statusCode: Int

    init(statusCode: Int) {
        self.statusCode = statusCode
    }
}

class RESTService: RemoteService {

    private let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

    func getDataFromURL(urlString: String, success: (NSData) -> (Void), failure: (ErrorType) -> (Void)) {
        guard let url = NSURL(string: urlString) else {
            failure(InvalidURLError())
            return
        }

        let urlRequest = NSURLRequest(URL: url)
        let dataTask = self.session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            guard let httpResponse = response as? NSHTTPURLResponse else {
                failure(error ?? UnexpectedError())
                return
            }

            guard (200...299 ~= httpResponse.statusCode) else {
                failure(InvalidResponseError(statusCode: httpResponse.statusCode))
                return
            }

            if let error = error {
                failure(error)
                return
            }

            guard let data = data else {
                failure(NoDataError())
                return
            }

            success(data)
        }
        dataTask.resume()
    }

}
