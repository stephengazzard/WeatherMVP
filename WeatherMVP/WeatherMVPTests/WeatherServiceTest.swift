//
//  WeatherServiceTest.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import Quick
import Nimble
@testable import WeatherMVP

class WeatherServiceTest: QuickSpec {

    override func spec() {


        describe("When fetching weather") {
            var subject: WeatherService!
            var fileService: FileService!
            beforeEach {
                fileService = FileService()
                subject = WeatherService(remoteService: fileService)
            }

            context("and the request is valid") {
                var weatherResponse: WeatherDayResponse?
                var error: ErrorType?
                beforeEach {
                    fileService.mockFileName = "dailyWeatherResponse.json"
                    subject.fetchWeatherForecast(forCity: "London", success: { (response) in
                        weatherResponse = response
                    }, failure: { (fetchError) in
                        error = fetchError
                    })
                }
                it("a valid weather response to be found") {
                    expect(weatherResponse).toEventuallyNot(beNil())
                }

                it("no error occurs") {
                    expect(error == nil).toNotEventually(beFalse())
                }
            }

            context("and the request is not valid") {
                var weatherResponse: WeatherDayResponse?
                var error: ErrorType?
                beforeEach {
                    fileService.mockFileName = "validJSON.json"
                    subject.fetchWeatherForecast(forCity: "London", success: { (response) in
                        weatherResponse = response
                    }, failure: { (fetchError) in
                        error = fetchError
                    })
                }
                it("no weather response to be reeived") {
                    expect(weatherResponse == nil).toNotEventually(beFalse())
                }

                it("no error occurs") {
                    expect(error).toEventuallyNot(beNil())
                }
            }

        }
    }

}
