import ProjectDescription

let targets: [Target] = [
    Target(
        name: "LightMeter",
        platform: .iOS,
        product: .framework,
        bundleId: "com.seunghun.lightmeter",
        deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
        sources: ["LightMeter/Sources/**"],
        dependencies: [],
        settings: .settings(
            base: ["SWIFT_STRICT_CONCURRENCY": "complete"]
        )
    ),
    Target(
        name: "LightMeterTests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "com.seunghun.lightmetertests",
        deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
        sources: ["LightMeterTests/Sources/**"],
        dependencies: [
            .target(name: "LightMeter")
        ],
        settings: .settings(
            base: [
                "DEVELOPMENT_TEAM": "5HZQ3M82FA",
                "SWIFT_STRICT_CONCURRENCY": "complete"
            ],
            configurations: [],
            defaultSettings: .recommended
        )
    ),
    Target(
        name: "LightMeterDemo",
        platform: .iOS,
        product: .app,
        bundleId: "com.seunghun.lightmeter.demo",
        deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
        infoPlist: .extendingDefault(with: ["UILaunchStoryboardName": "LaunchScreen"]),
        sources: ["LightMeterDemo/Sources/**"],
        resources: ["LightMeterDemo/Resources/**"],
        dependencies: [
            .target(name: "LightMeter")
        ],
        settings: .settings(
            base: [
                "DEVELOPMENT_TEAM": "5HZQ3M82FA",
                "SWIFT_STRICT_CONCURRENCY": "complete"
            ],
            configurations: [],
            defaultSettings: .recommended
        )
    )
]

let project = Project(
    name: "LightMeter",
    organizationName: "seunghun",
    targets: targets
)
