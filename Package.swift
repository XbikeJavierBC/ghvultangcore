// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ghvultangcore",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "ghvultangcore",
            targets: [
                "ghvultangcore"
            ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://gitlab.com/styme1/mobile/ios/dependencies/ghgungnircore.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/realm/realm-swift.git",
            branch: "master"
        )
    ],
    targets: [
        .target(
            name: "ghvultangcore",
            dependencies: [
                "ghgungnircore",
                .product(
                    name: "RealmSwift",
                    package: "realm-swift"
                )
            ]
        ),
        .testTarget(
            name: "ghvultangcoreTests",
            dependencies: [
                "ghvultangcore"
            ]
        ),
    ]
)
