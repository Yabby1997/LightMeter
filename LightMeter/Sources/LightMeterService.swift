//
//  LightMeterService.swift
//  LightMeter
//
//  Created by user on 2023/11/15.
//  Copyright © 2023 seunghun. All rights reserved.
//

import Foundation

public class LightMeterService {
    public init() {}
    
    public func foo() -> String {
        "Hello from LightMeter"
    }
    
    public func getExposureValue(iso: Int, shutterSpeed: Float, aperture: Float) -> Int {
        Int(round(log2((Float(100) * aperture * aperture) / (shutterSpeed * Float(iso)))))
    }
}
