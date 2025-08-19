// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "lightme_film_list",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "lightme_film_list",
            targets: ["lightme_film_list"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "lightme_film_list"
	    resources: [.process("films.json")]
	),
        .testTarget(
            name: "lightme_film_listTests",
            dependencies: ["lightme_film_list"]
        ),
    ]
)
