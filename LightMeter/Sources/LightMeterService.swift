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
    
    /// Errors that can be thrown by `LightMeterService`.
    public enum Errors: LocalizedError {
        /// The provided ISO value is invalid.
        case invalidIso
        /// The provided shutter speed value is invalid.
        case invalidShutterSpeed
        /// The provided aperture value is invalid.
        case invalidAperture
        
        public var errorDescription: String? {
            switch self {
            case .invalidIso: return "invalid ISO vlaue has been provided."
            case .invalidShutterSpeed: return "invalid shutter speed vlaue has been provided."
            case .invalidAperture: return "invalid aperture vlaue has been provided."
            }
        }
    }

    /// Initializes a new instance of LightMeterService.
    public init() {}

    /// Calculates the Exposure Value (EV) based on ISO, shutter speed, and aperture.
    ///
    /// - Parameters:
    ///   - iso: The sensitivity value for EV calculation.
    ///   - shutterSpeed: The shutter speed value for EV calculation.
    ///   - aperture: The aperture value for EV calculation.
    ///
    /// - Returns: The calculated Exposure Value as an integer.
    /// - Throws: ``Errors`` that occured while calculating.
    public func getExposureValue(
        iso: Int,
        shutterSpeed: Float,
        aperture: Float
    ) throws -> Int {
        guard iso > .zero else { throw Errors.invalidIso }
        guard shutterSpeed > .zero else { throw Errors.invalidShutterSpeed }
        guard aperture > .zero else { throw Errors.invalidAperture }
        return Int(round(log2((Float(100) * aperture * aperture) / (shutterSpeed * Float(iso)))))
    }
}
