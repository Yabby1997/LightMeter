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
    let shutterSpeedValues: [Float] = [1, 1 / 2, 1 / 4, 1 / 8, 1 / 15, 1 / 30, 1 / 60, 1 / 125, 1 / 250, 1 / 500, 1 / 1000]
    let apertureValues: [Float] = [1, 1.4, 2, 2.8, 4, 5.6, 8, 11, 16, 22]
    let exposureValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    override func setUpWithError() throws {}
    
    func testEvCalculate() {
        let expectedExposureValues: [Int] = apertureValues
            .enumerated()
            .flatMap { index, _ in
                exposureValues.map { $0 + index }
            }
        
        let resultExposureValues = apertureValues.flatMap { aperture in
            return shutterSpeedValues
                .compactMap { shutterSpeed in
                    try? LightMeterService.getExposureValue(
                        iso: 100,
                        shutterSpeed: shutterSpeed,
                        aperture: aperture
                    )
                }
                .map { Int(round($0)) }
        }
        
        XCTAssertEqual(expectedExposureValues, resultExposureValues)
    }
    
    func testEvCalculationZeroIso() {
        XCTAssertThrowsError(try LightMeterService.getExposureValue(iso: .zero, shutterSpeed: 1 / 4, aperture: 22))
    }
    
    func testEvCalculationNegativeIso() {
        XCTAssertThrowsError(try LightMeterService.getExposureValue(iso: -25, shutterSpeed: 1 / 500, aperture: 1.4))
    }
    
    func testEvCalculationZeroShutterSpeed() {
        XCTAssertThrowsError(try LightMeterService.getExposureValue(iso: 400, shutterSpeed: .zero, aperture: 2))
    }
    
    func testEvCalculationNegativeShutterSpeed() {
        XCTAssertThrowsError(try LightMeterService.getExposureValue(iso: 200, shutterSpeed: -1 / 16, aperture: 1.4))
    }
    
    func testEvCalculationZeroAperture() {
        XCTAssertThrowsError(try LightMeterService.getExposureValue(iso: 100, shutterSpeed: 1 / 8, aperture: .zero))
    }
    
    func testEvCalculationNegativeAperture() {
        XCTAssertThrowsError(try LightMeterService.getExposureValue(iso: 3200, shutterSpeed: 1 / 1000, aperture: -1))
    }
    
    func testIsoCalculate() {
        let expectedIsoValues = Array(repeating: 100, count: apertureValues.count * shutterSpeedValues.count)
        let resultIsoValues = apertureValues.enumerated()
            .flatMap { index, aperture in
                zip(shutterSpeedValues, exposureValues)
                    .compactMap { shutterSpeed, exposureValue in
                        try? LightMeterService.getIsoValue(
                            ev: Float(exposureValue + index),
                            shutterSpeed: shutterSpeed,
                            aperture: aperture
                        )
                    }
                    .compactMap { $0.nearest(among: [25.0, 100.0, 200.0, 400.0, 800.0, 1600.0, 3200.0]) }
                    .map { Int($0) }
            }
        
        XCTAssertEqual(expectedIsoValues, resultIsoValues)
    }
    
    func testIsoCalculationZeroShutterSpeed() {
        XCTAssertThrowsError(try LightMeterService.getIsoValue(ev: 1, shutterSpeed: .zero, aperture: 1.4))
    }
    
    func testIsoCalculationNegativeShutterSpeed() {
        XCTAssertThrowsError(try LightMeterService.getIsoValue(ev: 1, shutterSpeed: -30, aperture: 22))
    }
    
    func testIsoCalculationZeroAperture() {
        XCTAssertThrowsError(try LightMeterService.getIsoValue(ev: 1, shutterSpeed: 0.0005, aperture: .zero))
    }
    
    func testIsoCalculationNegativeAperture() {
        XCTAssertThrowsError(try LightMeterService.getIsoValue(ev: 1, shutterSpeed: 0.001, aperture: -1.2))
    }
    
    func testShutterSpeedCalculate() {
        let expectedShutterSpeedValues = Array(repeating: shutterSpeedValues, count: apertureValues.count).flatMap { $0 }
        let resultShutterSpeedValues = apertureValues.enumerated()
            .flatMap { index, aperture in
                exposureValues
                    .compactMap { exposureValue in
                        try? LightMeterService.getShutterSpeedValue(
                            ev: Float(exposureValue + index),
                            iso: 100,
                            aperture: aperture
                        )
                    }
                    .compactMap { $0.nearest(among: shutterSpeedValues) }
            }
        
        XCTAssertEqual(expectedShutterSpeedValues, resultShutterSpeedValues)
    }
    
    func testShutterSpeedCalculationZeroIso() {
        XCTAssertThrowsError(try LightMeterService.getShutterSpeedValue(ev: 7, iso: .zero, aperture: 1.4))
    }
    
    func testShutterSpeedCalculationNegativeIso() {
        XCTAssertThrowsError(try LightMeterService.getShutterSpeedValue(ev: -2, iso: -1600, aperture: 22))
    }
    
    func testShutterSpeedCalculationZeroAperture() {
        XCTAssertThrowsError(try LightMeterService.getShutterSpeedValue(ev: 1, iso: 100, aperture: .zero))
    }
    
    func testShutterSpeedCalculationNegativeAperture() {
        XCTAssertThrowsError(try LightMeterService.getShutterSpeedValue(ev: 9, iso: 400, aperture: -1.4))
    }
    
    func testApertureCalculate() {
        let expectedApertureValues = apertureValues.flatMap { Array(repeating: $0, count: shutterSpeedValues.count) }
        let resultApertureValues = apertureValues.enumerated()
            .flatMap { index, _ in
                zip(shutterSpeedValues, exposureValues)
                    .compactMap { shutterSpeed, exposureValue in
                        try? LightMeterService.getApertureValue(
                            ev: Float(exposureValue + index),
                            iso: 100,
                            shutterSpeed: shutterSpeed
                        )
                    }
                    .compactMap { $0.nearest(among: apertureValues) }
            }
        
        XCTAssertEqual(expectedApertureValues, resultApertureValues)
    }
    
    func testApertureCalculateZeroIso() {
        XCTAssertThrowsError(try LightMeterService.getApertureValue(ev: 7, iso: .zero, shutterSpeed: 1 / 2000))
    }
    
    func testApertureCalculateNegativeIso() {
        XCTAssertThrowsError(try LightMeterService.getApertureValue(ev: 4, iso: -25, shutterSpeed: 1 / 60))
    }
    
    func testApertureCalculateZeroShutterSpeed() {
        XCTAssertThrowsError(try LightMeterService.getApertureValue(ev: 7, iso: 100, shutterSpeed: .zero))
    }
    
    func testApertureCalculateNegativeShutterSpeed() {
        XCTAssertThrowsError(try LightMeterService.getApertureValue(ev: -4, iso: 50, shutterSpeed: -1 / 60))
    }
}
