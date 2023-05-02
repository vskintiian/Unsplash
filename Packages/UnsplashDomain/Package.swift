// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let ribs = Target.Dependency(stringLiteral: "RIBs")
let core = Target.Dependency(stringLiteral: "UnsplashCore")

let package = Package(
    name: "UnsplashDomain",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "DI", targets: ["DI"]),
        .library(name: "Extensions", targets: ["Extensions"]),
        .library(name: "Root", targets: ["Root"]),
        .library(name: "PhotoList", targets: ["PhotoList"])
    ],
    dependencies: [
        .package(path: "../UnsplashCore"),
        .package(url: "https://github.com/vskintiian/RIBs", from: "0.13.17")
    ],
    targets: [
        .target(
            name: "DI",
            dependencies: [
                "Root",
                core,
                ribs
            ]
        ),
        .target(
            name: "Extensions",
            dependencies: [
                core
            ]
        ),
        .target(
            name: "Root",
            dependencies: [
                ribs,
                "PhotoList"
            ],
            path: "Sources/Features/Root"
        ),
        .target(
            name: "PhotoList",
            dependencies: [
                ribs,
                "Extensions"
            ],
            path: "Sources/Features/PhotoList"
        ),
        .testTarget(
            name: "RootTests",
            dependencies: ["Root"]
        ),
    ]
)
