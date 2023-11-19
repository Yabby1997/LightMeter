//
//  LightMeterDemoViewModel.swift
//  LightMeterDemo
//
//  Created by Seunghun on 11/17/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import Combine
import Foundation
import LightMeter

final class LightMeterDemoViewModel: ObservableObject {
    private let lightMeterService = LightMeterService()
    
    @Published private(set) var exposureValue: Int = .zero
    @Published var iso: Float = 100.0
    @Published var shutterSpeed: Float = 1
    @Published var aperture: Float = 1.4
    
    init() {
        bind()
    }
    
    private func bind() {
        $iso.combineLatest($shutterSpeed, $aperture)
            .compactMap { [weak self] iso, shutterSpeed, aperture -> Float? in
                guard let self else { return nil }
                return try? lightMeterService.getExposureValue(
                    iso: iso,
                    shutterSpeed: shutterSpeed,
                    aperture: aperture
                )
            }
            .map { Int(round($0)) }
            .assign(to: &$exposureValue)
    }
}
