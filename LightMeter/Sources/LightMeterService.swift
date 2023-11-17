//
//  LightMeterService.swift
//  LightMeter
//
//  Created by user on 2023/11/15.
//  Copyright © 2023 seunghun. All rights reserved.
//

import Foundation

/// A service for light meter functionality, providing exposure value calculations.
public class LightMeterService {

    /// Initializes a new instance of LightMeterService.
    public init() {}

    public func foo() -> String {
        "Hello from LightMeter"
    }

    /// Calculates the Exposure Value (EV) based on ISO, shutter speed, and aperture.
    ///
    /// - Parameters:
    ///   - iso: The sensitivity value for EV calculation.
    ///   - shutterSpeed: The shutter speed value for EV calculation.
    ///   - aperture: The aperture value for EV calculation.
    ///
    /// - Returns: The calculated Exposure Value as an integer.
    public func getExposureValue(iso: Int, shutterSpeed: Float, aperture: Float) -> Int {
        Int(round(log2((Float(100) * aperture * aperture) / (shutterSpeed * Float(iso)))))
    }
}
