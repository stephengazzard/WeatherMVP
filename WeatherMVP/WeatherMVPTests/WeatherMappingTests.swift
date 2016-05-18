//
//  WeatherMappingTests.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import Quick
import Nimble
@testable import WeatherMVP

class WeatherMappingTests: QuickSpec {

    override func spec() {

        describe("Parsing a weather response") {
        
        context("from valid weather response JSON") {
            var weather: WeatherDayResponse?
            var error: ErrorType?
            beforeEach {
                let weatherJSONData = TestHelper.loadDataFromFileNamed("dailyWeatherResponse", fileExtension: "json")
                do {
                    let weatherJSON: [String: AnyObject] = try JSONDataParser().parseData(weatherJSONData)
                    weather = try WeatherDayResponse.createFromJSONDictionary(weatherJSON)
                } catch(let parseError) {
                    error = parseError
                }
            }

            it("does not yield an error") {
                expect(error).to(beNil())
            }

            it("loads a valid weather response") {
                expect(weather).toNot(beNil())
            }

            it("loads a weather response with 7 weather records") {
                expect(weather?.weatherRecords.count).to(equal(7))
            }

        }

            context("from a non weather-response JSON object") {
                var weather: WeatherDayResponse?
                var error: ErrorType?
                beforeEach {
                    let weatherJSONData = TestHelper.loadDataFromFileNamed("validJSON", fileExtension: "json")
                    do {
                        let weatherJSON: [String: AnyObject] = try JSONDataParser().parseData(weatherJSONData)
                        weather = try WeatherDayResponse.createFromJSONDictionary(weatherJSON)
                    } catch(let parseError) {
                        error = parseError
                    }
                }

                it("yields an error") {
                    expect(error).toNot(beNil())
                }

                it("does not load a valid weather response") {
                    expect(weather).to(beNil())
                }
            }
            
        }

        describe("Parsing an individual weather record") {
            context("with valid weather record JSON") {
                var weather: WeatherDayRecord?
                var error: ErrorType?
                beforeEach {
                    let weatherJSONData = TestHelper.loadDataFromFileNamed("weatherRecord", fileExtension: "json")
                    do {
                        let weatherJSON: [String: AnyObject] = try JSONDataParser().parseData(weatherJSONData)
                        weather = try WeatherDayRecord.createFromJSONDictionary(weatherJSON)
                    } catch(let parseError) {
                        error = parseError
                    }
                }

                it("does not throw an error") {
                    expect(error).to(beNil())
                }

                it("creates a valid weather record") {
                    expect(weather).toNot(beNil())
                }

                it("has a valid min and max temperature") {
                    expect(weather?.minTemperature).to(beCloseTo(12.09))
                    expect(weather?.maxTemperature).to(beCloseTo(14.44))
                }
            }

            context("with non-weather record JSON") {
                var weather: WeatherDayRecord?
                var error: ErrorType?
                beforeEach {
                    let weatherJSONData = TestHelper.loadDataFromFileNamed("validJSON", fileExtension: "json")
                    do {
                        let weatherJSON: [String: AnyObject] = try JSONDataParser().parseData(weatherJSONData)
                        weather = try WeatherDayRecord.createFromJSONDictionary(weatherJSON)
                    } catch(let parseError) {
                        error = parseError
                    }
                }

                it("throws an error") {
                    expect(error).toNot(beNil())
                }

                it("does not create a valid weather record") {
                    expect(weather).to(beNil())
                }

            }
        }
    }

}
