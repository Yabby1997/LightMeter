//
//  ShutterSpeedDemoView.swift
//  LightMeterDemo
//
//  Created by Seunghun on 11/20/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import SwiftUI

struct ShutterSpeedDemoView: View {
    @EnvironmentObject var viewModel: ShutterSpeedDemoViewModel
    
    var body: some View {
        VStack {
            ResultView(
                title: "Shutter Speed",
                value: String(
                    format: "%.3fs",
                    viewModel.shutterSpeed
                )
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
                title: "Aperture",
                subtitle: String(format: "ƒ%.1f", viewModel.aperture),
                valueRange: 1...22,
                value: $viewModel.aperture
            )
        }
        .padding()
    }
}

#Preview {
    ShutterSpeedDemoView()
        .environmentObject(ShutterSpeedDemoViewModel())
}
