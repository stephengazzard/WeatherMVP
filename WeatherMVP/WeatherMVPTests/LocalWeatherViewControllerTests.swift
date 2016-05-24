//
//  LocalWeatherViewControllerTests.swift
//  WeatherMVP
//
//  Created by Stephen Gazzard on 2016-05-20.
//  Copyright © 2016 TUI. All rights reserved.
//

import Quick
import Nimble
@testable import WeatherMVP

class LocalWeatherViewControllerTests: QuickSpec {

    override func spec() {
        var subject: LocalWeatherViewController!
        beforeEach {
            let wireframe = WeatherWireframe()!
            subject = wireframe.instantiateMyWeatherPage()
            subject.loadView()
        }

        describe("When setting weather response") {

            context("to nil") {
                beforeEach {
                    subject.setWeatherData(nil)
                }

                it("weather response shows 0 objects") {
                    expect(subject.collectionView(subject.weatherCollectionView, numberOfItemsInSection: 0)).to(equal(0))
                }
            }

            context("to an empty response") {
                beforeEach {
                    subject.setWeatherData(WeatherDayResponse(weatherRecords: []))
                }

                it("weather response shows 0 objects") {
                    expect(subject.collectionView(subject.weatherCollectionView, numberOfItemsInSection: 0)).to(equal(0))
                }
            }

            context("to five objects") {
                beforeEach {
                    subject.setWeatherData(WeatherDayResponse(weatherRecords: [
                        WeatherDayRecord(minTemperature: 0, maxTemperature: 1),
                        WeatherDayRecord(minTemperature: 0, maxTemperature: 1),
                        WeatherDayRecord(minTemperature: 0, maxTemperature: 1),
                        WeatherDayRecord(minTemperature: 0, maxTemperature: 1),
                        WeatherDayRecord(minTemperature: 0, maxTemperature: 1)
                        ]))
                }

                it("weather response shows 0 objects") {
                    expect(subject.collectionView(subject.weatherCollectionView, numberOfItemsInSection: 0)).to(equal(5))
                }
            }
        }

        describe("When setting weather load state") {

            context("to loading") {
                beforeEach {
                    subject.setWeatherLoadState(.Loading)
                }

                it("the spinner spins") {
                    expect(subject.activityIndicator.isAnimating()).to(beTrue())
                }

                it("shows a 'loading' string") {
                    expect(subject.lastUpdatedLabel.text).to(equal(LocalWeatherViewController.Constants.LoadingMessage))
                }

                it("the error label is blank") {
                    expect(subject.errorMessageLabel.text).to(equal(""))
                }
            }

            context("to loaded") {
                context("when a weather response has previously been loaded") {
                    var loadedWeatherResponse: WeatherDayResponse!
                    beforeEach {
                        loadedWeatherResponse = WeatherDayResponse(weatherRecords: [])
                        subject.setWeatherData(loadedWeatherResponse)
                        subject.setWeatherLoadState(.Loaded)
                    }

                    it("the spinner does not spin") {
                        expect(subject.activityIndicator.isAnimating()).to(beFalse())
                    }

                    it("the timestamp of the load is shown") {
                        expect(subject.lastUpdatedLabel.text).to(equal(UpdatedAtDateFormatter.format(loadedWeatherResponse.updatedTimeStamp)))
                    }

                    it("the error label is blank") {
                        expect(subject.errorMessageLabel.text).to(equal(""))
                    }
                }

                context("when a weather response has not previously been loaded") {
                    beforeEach {
                        subject.setWeatherData(nil)
                        subject.setWeatherLoadState(.Loaded)
                    }

                    it("the spinner does not spin") {
                        expect(subject.activityIndicator.isAnimating()).to(beFalse())
                    }

                    it("the loading message is empty") {
                        expect(subject.lastUpdatedLabel.text).to(equal(""))
                    }

                    it("the error label is blank") {
                        expect(subject.errorMessageLabel.text).to(equal(""))
                    }
                }
            }

            context("to load failed") {
                var errorString: String!
                beforeEach {
                    errorString = "Failed to load"
                }
                context("when a weather response has previously been loaded") {
                    var loadedWeatherResponse: WeatherDayResponse!
                    beforeEach {
                        loadedWeatherResponse = WeatherDayResponse(weatherRecords: [])
                        subject.setWeatherData(loadedWeatherResponse)
                        subject.setWeatherLoadState(.LoadFailed(reason: errorString))
                    }

                    it("the spinner does not spin") {
                        expect(subject.activityIndicator.isAnimating()).to(beFalse())
                    }
                    
                    it("the error message is shown") {
                        expect(subject.errorMessageLabel.text).to(equal(errorString))
                    }

                    it("the timestamp of the load is shown") {
                        expect(subject.lastUpdatedLabel.text).to(equal(UpdatedAtDateFormatter.format(loadedWeatherResponse.updatedTimeStamp)))
                    }
                }
            }
        }
        
    }
    
}
