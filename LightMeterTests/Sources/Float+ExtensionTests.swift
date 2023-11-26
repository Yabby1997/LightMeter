//
//  Float+ExtensionTests.swift
//  LightMeterTests
//
//  Created by Seunghun on 11/19/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import XCTest
@testable import LightMeter

final class Float_ExtensionTests: XCTestCase {
    func testNearestAmong() {
        let floats: [Float] = [
            -5.0, -1.26, -1.25,
             -1.24, 3.74, 3.75,
             3.76, 7.49, 7.5,
             7.6, 10, 58992.0,
        ]
        
        XCTAssertEqual(
            floats.compactMap { $0.nearest(among: [-5.0, 2.5, 5.0, 10.0]) },
            [
                -5.0, -5.0, -5.0,
                 2.5, 2.5, 2.5,
                 5.0, 5.0, 5.0,
                 10.0, 10.0, 10.0,
            ]
        )
    }
}
