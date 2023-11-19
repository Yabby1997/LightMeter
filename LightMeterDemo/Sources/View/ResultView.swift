//
//  ResultView.swift
//  LightMeterDemo
//
//  Created by Seunghun on 11/19/23.
//  Copyright © 2023 seunghun. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    let title: String
    let value: String
    var body: some View {
        VStack {
            Text(title)
                .font(.title3)
            Text(value)
                .font(.system(size: 120, weight: .bold))
        }
    }
}

#Preview {
    ResultView(title: "Demo", value: "42")
}
