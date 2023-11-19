//
//  LightMeterDemoView.swift
//  LightMeterDemo
//
//  Created by Seunghun on 11/17/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import SwiftUI

struct LightMeterDemoView: View {
    @EnvironmentObject var viewModel: LightMeterDemoViewModel
    
    var body: some View {
        VStack {
            Text("EV")
                .font(.title3)
            Text("\(viewModel.exposureValue)")
                .font(.system(size: 120, weight: .bold))
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
    LightMeterDemoView()
        .environmentObject(LightMeterDemoViewModel())
}
