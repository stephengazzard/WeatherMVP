//
//  JSONParserTests.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-18.
//  Copyright © 2016 TUI. All rights reserved.
//

import Quick
import Nimble
@testable import WeatherMVP

class JSONParserTests: QuickSpec {
    
    override func spec() {
        describe("With a JSON Parser") {
            var parser: JSONDataParser!
            beforeEach {
                parser = JSONDataParser()
            }

            context("When parsing a valid JSON file") {
                var jsonData: NSData!
                beforeEach {
                    jsonData = TestHelper.loadDataFromFileNamed("validJSON", fileExtension: "json")
                }

                context("to the type that matches the json file") {
                    var jsonResponse: [String: AnyObject]?
                    var error: ErrorType?
                    beforeEach {
                        do {
                            jsonResponse = try parser.parseData(jsonData)
                        } catch(let parseError) {
                            error = parseError
                        }
                    }

                    it("does not throw an error") {
                        expect(error).to(beNil())
                    }

                    it("parses the JSON") {
                        expect(jsonResponse).toNot(beNil())
                    }
                }

                context("to a type that doesn't match the json file") {
                    var jsonResponse: [[String: AnyObject]]?
                    var error: ErrorType?
                    beforeEach {
                        do {
                            jsonResponse = try parser.parseData(jsonData)
                        } catch(let parseError) {
                            error = parseError
                        }
                    }

                    it("throws an error") {
                        expect(error as? InvalidDataError).toNot(beNil())
                    }

                    it("does not return an object") {
                        expect(jsonResponse).to(beNil())
                    }
                }
            }

            context("When parsing a malformed JSON file") {
                var jsonResponse: [String: AnyObject]?
                var error: ErrorType?

                beforeEach {
                    let jsonData = TestHelper.loadDataFromFileNamed("malformedJSON", fileExtension: "json")
                    do {
                        jsonResponse = try parser.parseData(jsonData)
                    } catch(let parseError) {
                        error = parseError
                    }
                }

                it("throws an error") {
                    expect(error).toNot(beNil())
                }

                it("does not parse the JSON") {
                    expect(jsonResponse).to(beNil())
                }
            }

            context("When parsing a non-JSON file") {
                var jsonResponse: [String: AnyObject]?
                var error: ErrorType?

                beforeEach {
                    let jsonData = TestHelper.loadDataFromFileNamed("nonJSON", fileExtension: "dat")
                    do {
                        jsonResponse = try parser.parseData(jsonData)
                    } catch(let parseError) {
                        error = parseError
                    }
                }

                it("throws an error") {
                    expect(error).toNot(beNil())
                }

                it("does not parse the JSON") {
                    expect(jsonResponse).to(beNil())
                }
            }
        }
    }
    
}
