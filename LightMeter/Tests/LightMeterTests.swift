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
            return shutterSpeeds
                .compactMap { shutterSpeed in
                    try? lightMeterService.getExposureValue(
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
        XCTAssertThrowsError(try lightMeterService.getExposureValue(iso: .zero, shutterSpeed: 1 / 4, aperture: 22))
    }
    
    func testEvCalculationNegativeIso() {
        XCTAssertThrowsError(try lightMeterService.getExposureValue(iso: -25, shutterSpeed: 1 / 500, aperture: 1.4))
    }
    
    func testEvCalculationZeroShutterSpeed() {
        XCTAssertThrowsError(try lightMeterService.getExposureValue(iso: 400, shutterSpeed: .zero, aperture: 2))
    }
    
    func testEvCalculationNegativeShutterSpeed() {
        XCTAssertThrowsError(try lightMeterService.getExposureValue(iso: 200, shutterSpeed: -1 / 16, aperture: 1.4))
    }
    
    func testEvCalculationZeroAperture() {
        XCTAssertThrowsError(try lightMeterService.getExposureValue(iso: 100, shutterSpeed: 1 / 8, aperture: .zero))
    }
    
    func testEvCalculationNegativeAperture() {
        XCTAssertThrowsError(try lightMeterService.getExposureValue(iso: 3200, shutterSpeed: 1 / 1000, aperture: -1))
    }
    
    func testIsoCalculate() {
        let shutterSpeeds: [Float] = [1, 1 / 2, 1 / 4, 1 / 8, 1 / 15, 1 / 30, 1 / 60, 1 / 125, 1 / 250, 1 / 500, 1 / 1000]
        let apertures: [Float] = [1, 1.4, 2, 2.8, 4, 5.6, 8, 11, 16, 22]
        let exposureValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        let resultIsoValues = apertures.enumerated()
            .flatMap { index, aperture in
                zip(shutterSpeeds, exposureValues)
                    .compactMap { shutterSpeed, exposureValue in
                        try? lightMeterService.getIsoValue(
                            ev: Float(exposureValue + index),
                            shutterSpeed: shutterSpeed,
                            aperture: aperture
                        )
                    }
                    .compactMap { $0.nearest(among: [25.0, 100.0, 200.0, 400.0, 800.0, 1600.0, 3200.0]) }
                    .map { Int($0) }
            }
        
        XCTAssertEqual(resultIsoValues, Array(repeating: 100, count: apertures.count * shutterSpeeds.count))
    }
    
    func testIsoCalculationZeroShutterSpeed() {
        XCTAssertThrowsError(try lightMeterService.getIsoValue(ev: 1, shutterSpeed: .zero, aperture: 1.4))
    }
    
    func testIsoCalculationNegativeShutterSpeed() {
        XCTAssertThrowsError(try lightMeterService.getIsoValue(ev: 1, shutterSpeed: -30, aperture: 22))
    }
    
    func testIsoCalculationZeroAperture() {
        XCTAssertThrowsError(try lightMeterService.getIsoValue(ev: 1, shutterSpeed: 0.0005, aperture: .zero))
    }
    
    func testIsoCalculationNegativeAperture() {
        XCTAssertThrowsError(try lightMeterService.getIsoValue(ev: 1, shutterSpeed: 0.001, aperture: -1.2))
    }
    
    func testShutterSpeedCalculate() {
        let shutterSpeeds: [Float] = [1, 1 / 2, 1 / 4, 1 / 8, 1 / 15, 1 / 30, 1 / 60, 1 / 125, 1 / 250, 1 / 500, 1 / 1000]
        let apertures: [Float] = [1, 1.4, 2, 2.8, 4, 5.6, 8, 11, 16, 22]
        let exposureValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        let resultShutterSpeedValues = apertures.enumerated()
            .flatMap { index, aperture in
                zip(shutterSpeeds, exposureValues)
                    .compactMap { shutterSpeed, exposureValue in
                        try? lightMeterService.getShutterSpeedValue(
                            ev: Float(exposureValue + index),
                            iso: 100,
                            aperture: aperture
                        )
                    }
                    .compactMap { $0.nearest(among: shutterSpeeds) }
            }
        
        XCTAssertEqual(resultShutterSpeedValues, Array(repeating: shutterSpeeds, count: apertures.count).flatMap { $0 })
    }
    
    func testShutterSpeedCalculationZeroIso() {
        XCTAssertThrowsError(try lightMeterService.getShutterSpeedValue(ev: 7, iso: .zero, aperture: 1.4))
    }
    
    func testShutterSpeedCalculationNegativeIso() {
        XCTAssertThrowsError(try lightMeterService.getShutterSpeedValue(ev: -2, iso: -1600, aperture: 22))
    }
    
    func testShutterSpeedCalculationZeroAperture() {
        XCTAssertThrowsError(try lightMeterService.getShutterSpeedValue(ev: 1, iso: 100, aperture: .zero))
    }
    
    func testShutterSpeedCalculationNegativeAperture() {
        XCTAssertThrowsError(try lightMeterService.getShutterSpeedValue(ev: 9, iso: 400, aperture: -1.4))
    }
}
