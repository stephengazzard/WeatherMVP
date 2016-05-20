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

    }

}
