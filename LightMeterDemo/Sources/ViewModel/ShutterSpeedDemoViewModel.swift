//
//  ShutterSpeedDemoViewModel.swift
//  LightMeterDemo
//
//  Created by Seunghun on 11/20/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import Foundation
import LightMeter

final class ShutterSpeedDemoViewModel: ObservableObject {
    private let lightMeterService = LightMeterService()
    
    @Published private(set) var shutterSpeed: Float = .zero
    @Published var exposureValue: Float = 1
    @Published var iso: Float = 100
    @Published var aperture: Float = 1.4
    
    init() {
        bind()
    }
    
    private func bind() {
        $exposureValue.combineLatest($iso, $aperture)
            .compactMap { [weak self] ev, iso, aperture -> Float? in
                guard let self else { return nil }
                return try? lightMeterService.getShutterSpeedValue(
                    ev: exposureValue,
                    iso: iso,
                    aperture: aperture
                )
            }
            .compactMap {
                $0.nearest(
                    among: [60, 30, 15, 8, 4, 2, 1, 1 / 2, 1 / 4, 1 / 8, 1 / 15, 1 / 30, 1 / 60, 1 / 125, 1 / 250, 1 / 500, 1 / 1000]
                )
            }
            .assign(to: &$shutterSpeed)
    }
}
