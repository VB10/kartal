// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "url_launcher_ios", path: "../.packages/url_launcher_ios-6.4.1"),
        .package(name: "share_plus", path: "../.packages/share_plus-11.1.0"),
        .package(name: "package_info_plus", path: "../.packages/package_info_plus-8.3.1"),
        .package(name: "network_info_plus", path: "../.packages/network_info_plus-6.1.4"),
        .package(name: "device_info_plus", path: "../.packages/device_info_plus-11.5.0"),
        .package(name: "connectivity_plus", path: "../.packages/connectivity_plus-6.1.5"),
        .package(name: "FlutterFramework", path: "../.packages/FlutterFramework")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "url-launcher-ios", package: "url_launcher_ios"),
                .product(name: "share-plus", package: "share_plus"),
                .product(name: "package-info-plus", package: "package_info_plus"),
                .product(name: "network-info-plus", package: "network_info_plus"),
                .product(name: "device-info-plus", package: "device_info_plus"),
                .product(name: "connectivity-plus", package: "connectivity_plus"),
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
