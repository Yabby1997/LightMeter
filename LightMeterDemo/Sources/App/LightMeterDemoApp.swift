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
                ISODemoView()
                    .environmentObject(ISODemoViewModel())
                    .tabItem { Text("ISO") }
                ShutterSpeedDemoView()
                    .environmentObject(ShutterSpeedDemoViewModel())
                    .tabItem { Text("Shutter") }
                ApertureValueDemoView()
                    .environmentObject(ApertureValueDemoViewModel())
                    .tabItem { Text("Aperture") }
            }
        }
    }
}
