// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HelloPython",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/pvieito/PythonKit.git", from: "0.3.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "HelloPython",
            dependencies: [
                "PythonKit",
            ]),
        .testTarget(
            name: "HelloPythonTests",
            dependencies: ["HelloPython"]),
    ]
)
