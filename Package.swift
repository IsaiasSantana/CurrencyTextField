// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CurrencyTextField",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CurrencyTextField",
            targets: ["CurrencyTextField"]
        ),
    ],
    targets: [
        .target(
            name: "CurrencyTextField"),
        .testTarget(
            name: "CurrencyTextFieldTests",
            dependencies: ["CurrencyTextField"]
        ),
    ]
)
