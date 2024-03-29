// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YotiButtonSDK",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "YotiButtonSDK",
            targets: ["YotiButtonSDK"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "YotiButtonSDK",
            dependencies: [],
            exclude: ["Info.plist"],
            resources: [.process("Resources/Roboto-Medium.ttf"),
                        .process("Resources/NunitoSans-Bold.ttf")]),
        .testTarget(
            name: "YotiButtonSDKTests",
            dependencies: ["YotiButtonSDK"],
            exclude: ["Info.plist", "UnitTestPlan.xctestplan"]),
    ]
)
