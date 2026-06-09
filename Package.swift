// swift-tools-version:5.11
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SymbolPicker",
  defaultLocalization: "en",
  platforms: [
    .macOS(.v13),
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "SymbolPicker",
      targets: ["SymbolPicker"]),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "SymbolPicker",
      resources: [
        .process("Resources/macOS13"),
        .process("Resources/macOS14"),
        .process("Resources/macOS15"),
        .process("Resources/macOS26"),
      ]),
  ]
)
