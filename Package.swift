// swift-tools-version:5.2

/**
 *  Magick-plugin for Publish
 *  Copyright (c) Michele Volpato 2020
 *  MIT license, see LICENSE file for details
 */

import PackageDescription

let package = Package(
    name: "MagickPublishPlugin",
    products: [
        .library(
            name: "MagickPublishPlugin",
            targets: ["MagickPublishPlugin"]),
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.5.0"),
        .package(name: "ShellOut", url: "https://github.com/johnsundell/shellout.git", from: "2.3.0")
    ],
    targets: [
        .target(
            name: "MagickPublishPlugin",
            dependencies: ["ShellOut", "Publish"]),
        .testTarget(
            name: "MagickPublishPluginTests",
            dependencies: ["MagickPublishPlugin"]),
    ]
)
