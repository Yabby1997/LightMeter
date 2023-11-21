//
//  ApertureValueDemoViewModel.swift
//  LightMeterDemo
//
//  Created by Seunghun on 11/21/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import Foundation
import LightMeter

final class ApertureValueDemoViewModel: ObservableObject {
    private let lightMeterService = LightMeterService()
    
    @Published private(set) var aperture: Float = 1.4
    @Published var exposureValue: Float = .zero
    @Published var iso: Float = 100.0
    @Published var shutterSpeed: Float = 1
    
    init() {
        bind()
    }
    
    private func bind() {
        $exposureValue.combineLatest($iso, $shutterSpeed)
            .compactMap { [weak self] ev, iso, shutterSpeed -> Float? in
                guard let self else { return nil }
                return try? lightMeterService.getApertureValue(
                    ev: ev,
                    iso: iso,
                    shutterSpeed: shutterSpeed
                )
            }
            .compactMap {
                $0.nearest(among: [1, 1.4, 2, 2.8, 4, 5.6, 8, 11, 16, 22])
            }
            .assign(to: &$aperture)
    }
}
