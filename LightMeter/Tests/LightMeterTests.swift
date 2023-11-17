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
            shutterSpeeds.map { shutterSpeed in
                lightMeterService.getExposureValue(
                    iso: 100,
                    shutterSpeed: shutterSpeed,
                    aperture: aperture
                )
            }
        }
        
        XCTAssertEqual(expectedExposureValues, resultExposureValues)
    }
}
