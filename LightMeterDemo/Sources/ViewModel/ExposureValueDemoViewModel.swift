//
//  ExposureValueDemoViewModel.swift
//  LightMeterDemo
//
//  Created by Seunghun on 11/17/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import Combine
import Foundation
import LightMeter

final class ExposureValueDemoViewModel: ObservableObject {
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
                return try? LightMeterService.getExposureValue(
                    iso: iso,
                    shutterSpeed: shutterSpeed,
                    aperture: aperture
                )
            }
            .map { Int(round($0)) }
            .assign(to: &$exposureValue)
    }
}
