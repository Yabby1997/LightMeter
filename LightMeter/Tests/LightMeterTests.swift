//
//  LightMeterTests.swift
//  LightMeterTests
//
//  Created by Seunghun on 11/17/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import XCTest
@testable import LightMeter

final class LightMeterTests: XCTestCase {
    private let lightMeterService = LightMeterService()
    
    override func setUpWithError() throws {}
    
    func testEvCalculate() {
        let shutterSpeeds: [Float] = [1, 1 / 2, 1 / 4, 1 / 8, 1 / 15, 1 / 30, 1 / 60, 1 / 125, 1 / 250, 1 / 500, 1 / 1000]
        let apertures: [Float] = [1, 1.4, 2, 2.8, 4, 5.6, 8, 11, 16, 22]
        let defaultExposureValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let expectedExposureValues: [Int] = apertures
            .enumerated()
            .flatMap { index, _ in
                defaultExposureValues.map { $0 + index }
            }
        
        let resultExposureValues = apertures.flatMap { aperture in
            shutterSpeeds.compactMap { shutterSpeed in
                try? lightMeterService.getExposureValue(
                    iso: 100,
                    shutterSpeed: shutterSpeed,
                    aperture: aperture
                )
            }
        }
        
        XCTAssertEqual(expectedExposureValues, resultExposureValues)
    }
    
    func testZeroIso() {
        XCTAssertThrowsError(try lightMeterService.getExposureValue(iso: .zero, shutterSpeed: 1 / 4, aperture: 22))
    }
    
    func testNegativeIso() {
        XCTAssertThrowsError(try lightMeterService.getExposureValue(iso: -25, shutterSpeed: 1 / 500, aperture: 1.4))
    }
    
    func testZeroShutterSpeed() {
        XCTAssertThrowsError(try lightMeterService.getExposureValue(iso: 400, shutterSpeed: .zero, aperture: 2))
    }
    
    func testNegativeShutterSpeed() {
        XCTAssertThrowsError(try lightMeterService.getExposureValue(iso: 200, shutterSpeed: -1 / 16, aperture: 1.4))
    }
    
    func testZeroAperture() {
        XCTAssertThrowsError(try lightMeterService.getExposureValue(iso: 100, shutterSpeed: 1 / 8, aperture: .zero))
    }
    
    func testNegativeAperture() {
        XCTAssertThrowsError(try lightMeterService.getExposureValue(iso: 3200, shutterSpeed: 1 / 1000, aperture: -1))
    }
}
