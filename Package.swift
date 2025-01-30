// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Formidable",
    platforms: [.iOS(.v17), .macOS(.v15), .tvOS(.v17)],
    products: [
        .library(
            name: "Formidable",
            targets: ["Formidable"]),
    ],
    targets: [
        .target(
            name: "Formidable"
        ),
        .testTarget(
            name: "FormidableTests",
            dependencies: ["Formidable"]
        )
    ]
)
