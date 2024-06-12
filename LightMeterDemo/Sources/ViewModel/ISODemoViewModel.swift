//
//  ISODemoViewModel.swift
//  LightMeterDemo
//
//  Created by Seunghun on 11/19/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import Foundation
import LightMeter

final class ISODemoViewModel: ObservableObject {
    @Published private(set) var iso: Int = 100
    @Published var exposureValue: Float = 1
    @Published var shutterSpeed: Float = 1
    @Published var aperture: Float = 1.4
    
    init() {
        bind()
    }
    
    private func bind() {
        $exposureValue.combineLatest($shutterSpeed, $aperture)
            .compactMap { [weak self] exposureValue, shutterSpeed, aperture -> Float? in
                guard let self else { return nil }
                return try? LightMeterService.getIsoValue(
                    ev: exposureValue,
                    shutterSpeed: shutterSpeed,
                    aperture: aperture
                )
            }
            .compactMap { $0.nearest(among: [25, 100, 200, 400, 800, 1600, 3200]) }
            .map { Int(round($0)) }
            .assign(to: &$iso)
    }
}
