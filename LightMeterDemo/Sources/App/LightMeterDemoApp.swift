import SwiftUI
import LightMeter

@main
struct LightMeterDemoApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ExposureValueDemoView()
                    .environmentObject(ExposureValueDemoViewModel())
                    .tabItem { Text("EV") }
            }
        }
    }
}
