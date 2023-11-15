import SwiftUI
import LightMeter

@main
struct LightMeterDemoApp: App {
    let lightMeter = LightMeterService()
    var body: some Scene {
        WindowGroup {
            Text("Hello from LightMeterDemoApp") + Text("\n") + Text(lightMeter.foo())
        }
    }
}
