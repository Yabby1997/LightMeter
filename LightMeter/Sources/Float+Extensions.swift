//
//  Float+Extensions.swift
//  LightMeter
//
//  Created by Seunghun on 11/19/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import Foundation

extension Float {
    public func nearest(among: [Float]) -> Float? {
        return among.min { abs($0 - self) < abs($1 - self) }
    }
}
