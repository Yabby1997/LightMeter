//
//  ApertureValueDemoView.swift
//  LightMeterDemo
//
//  Created by Seunghun on 11/21/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import SwiftUI

struct ApertureValueDemoView: View {
    @EnvironmentObject var viewModel: ApertureValueDemoViewModel
    
    var body: some View {
        VStack {
            ResultView(
                title: "Aperture",
                value: String(format: "ƒ%.1f", viewModel.aperture)
            )
            ValueSlider(
                title: "EV",
                subtitle: "\(Int(viewModel.exposureValue))",
                valueRange: -20...20,
                value: $viewModel.exposureValue
            )
            ValueSlider(
                title: "ISO",
                subtitle: "\(Int(viewModel.iso))",
                valueRange: 25...3200,
                value: $viewModel.iso
            )
            ValueSlider(
                title: "Shutter",
                subtitle: String(format: "%.4fs", viewModel.shutterSpeed),
                valueRange: 0.0005...30,
                value: $viewModel.shutterSpeed
            )
        }
        .padding()
    }
}

#Preview {
    ApertureValueDemoView()
        .environmentObject(ApertureValueDemoViewModel())
}
