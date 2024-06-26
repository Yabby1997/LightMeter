//
//  LightMeterService.swift
//  LightMeter
//
//  Created by user on 2023/11/15.
//  Copyright © 2023 seunghun. All rights reserved.
//

import Foundation

/// A service for light meter functionality, providing exposure value calculations.
public enum LightMeterService {
    
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
            case .invalidIso: return "invalid ISO value has been provided."
            case .invalidShutterSpeed: return "invalid shutter speed value has been provided."
            case .invalidAperture: return "invalid aperture value has been provided."
            }
        }
    }

    /// Calculates the Exposure Value (EV) based on ISO, shutter speed, and aperture.
    ///
    /// - Parameters:
    ///   - iso: The sensitivity value for EV calculation.
    ///   - shutterSpeed: The shutter speed value for EV calculation.
    ///   - aperture: The aperture value for EV calculation.
    ///
    /// - Returns: The calculated Exposure Value as an float.
    /// - Throws: ``Errors`` that occured while calculating.
    public static func getExposureValue(
        iso: Float,
        shutterSpeed: Float,
        aperture: Float
    ) throws -> Float {
        guard iso > .zero else { throw Errors.invalidIso }
        guard shutterSpeed > .zero else { throw Errors.invalidShutterSpeed }
        guard aperture > .zero else { throw Errors.invalidAperture }
        return log2((100.0 * aperture * aperture) / (shutterSpeed * iso))
    }
    
    /// Calculates the ISO value based on EV, shutter speed, and aperture.
    ///
    /// - Parameters:
    ///     - ev: The exposure value for ISO calculation.
    ///     - shutterSpeed: The shutter speed value for ISO calculation.
    ///     - aperture: The aperture value for ISO calculation.
    ///
    /// - Returns: The calculated ISO value as an float.
    /// - Throws: ``Errors`` that occured while calculating.
    public static func getIsoValue(
        ev: Float,
        shutterSpeed: Float,
        aperture: Float
    ) throws -> Float {
        guard shutterSpeed > .zero else { throw Errors.invalidShutterSpeed }
        guard aperture > .zero else { throw Errors.invalidAperture }
        return (100.0 * aperture * aperture) / (pow(2.0, ev) * shutterSpeed)
    }
    
    /// Calculates the shutter speed based on EV, ISO, and aperture.
    ///
    /// - Parameters:
    ///     - ev: The exposure value for shutter speed calculation.
    ///     - iso: The ISO value for shutter speed calculation.
    ///     - aperture: The aperture value for shutter speed calculation.
    ///
    /// - Returns: The calculated shutter speed as an float.
    /// - Throws: ``Errors`` that occured while calculating.
    public static func getShutterSpeedValue(
        ev: Float,
        iso: Float,
        aperture: Float
    ) throws -> Float {
        guard iso > .zero else { throw Errors.invalidIso }
        guard aperture > .zero else { throw Errors.invalidAperture }
        return (100.0 * pow(aperture, 2)) / (iso * pow(2.0, ev))
    }
    
    /// Calculates the aperture value based on EV, ISO, and shutter speed.
    ///
    /// - Parameters:
    ///     - ev: The exposure value for aperture value calculation.
    ///     - iso: The ISO value for aperture value calculation.
    ///     - shutterSpeed: The shutter speed for aperture value calculation.
    ///
    /// - Returns: The calculated aperture value as an float.
    /// - Throws: ``Errors`` that occured while calculating.
    public static func getApertureValue(
        ev: Float,
        iso: Float,
        shutterSpeed: Float
    ) throws -> Float {
        guard iso > .zero else { throw Errors.invalidIso }
        guard shutterSpeed > .zero else { throw Errors.invalidShutterSpeed }
        return sqrt((iso * shutterSpeed * pow(2.0, ev)) / 100.0)
    }
}
