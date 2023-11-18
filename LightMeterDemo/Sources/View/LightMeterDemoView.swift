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
            HStack {
                VStack(alignment: .center) {
                    Text("ISO")
                        .font(.headline)
                    Text("\(viewModel.iso)")
                        .font(.subheadline)
                }
                .frame(width: 80)
                Spacer()
                Slider(
                    value: Binding { Float(viewModel.iso) } set: { viewModel.iso = Int($0) },
                    in: 25...3200
                )
            }
            HStack {
                VStack(alignment: .center) {
                    Text("Shutter")
                        .font(.headline)
                    Text("\(viewModel.shutterSpeed, specifier: "%.4f")s")
                        .font(.subheadline)
                }
                .frame(width: 80)
                Spacer()
                Slider(
                    value: $viewModel.shutterSpeed,
                    in: 1 / 2000...30
                )
            }
            HStack {
                VStack(alignment: .center) {
                    Text("Aperture")
                        .font(.headline)
                    Text("ƒ\(viewModel.aperture, specifier: "%.1f")")
                        .font(.subheadline)
                }
                .frame(width: 80)
                Spacer()
                Slider(
                    value: $viewModel.aperture,
                    in: 1...22
                )
            }
        }
        .padding()
    }
}

#Preview {
    LightMeterDemoView()
        .environmentObject(LightMeterDemoViewModel())
}
