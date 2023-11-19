//
//  ISODemoView.swift
//  LightMeterDemo
//
//  Created by Seunghun on 11/19/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import SwiftUI

struct ISODemoView: View {
    @EnvironmentObject var viewModel: ISODemoViewModel
    
    var body: some View {
        VStack {
            ResultView(
                title: "ISO",
                value: "\(viewModel.iso)"
            )
            ValueSlider(
                title: "EV",
                subtitle: "\(Int(viewModel.exposureValue))",
                valueRange: -20...20,
                value: $viewModel.exposureValue
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
    ISODemoView()
        .environmentObject(ISODemoViewModel())
}
