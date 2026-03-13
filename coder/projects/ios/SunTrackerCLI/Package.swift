// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SunTrackerCLI",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "SunTrackerCLI", targets: ["SunTrackerCLI"])
    ],
    targets: [
        .executableTarget(
            name: "SunTrackerCLI",
            dependencies: [],
            path: "Sources"
        )
    ]
)
