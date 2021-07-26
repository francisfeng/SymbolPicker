// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SymbolPicker",
  defaultLocalization: "en",
  platforms: [
    .macOS(.v10_15),
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "SymbolPicker",
      targets: ["SymbolPicker"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "SymbolPicker",
      dependencies: [],
      resources: [
        .process("Resources/SF Symbols/All.txt"),
        .process("Resources/SF Symbols/Arrows.txt"),
        .process("Resources/SF Symbols/Commerce.txt"),
        .process("Resources/SF Symbols/Communication.txt"),
        .process("Resources/SF Symbols/Connectivity.txt"),
        .process("Resources/SF Symbols/Devices.txt"),
        .process("Resources/SF Symbols/Editing.txt"),
        .process("Resources/SF Symbols/Gaming.txt"),
        .process("Resources/SF Symbols/Health.txt"),
        .process("Resources/SF Symbols/Human.txt"),
        .process("Resources/SF Symbols/Indices.txt"),
        .process("Resources/SF Symbols/Keyboard.txt"),
        .process("Resources/SF Symbols/Math.txt"),
        .process("Resources/SF Symbols/Media.txt"),
        .process("Resources/SF Symbols/Nature.txt"),
        .process("Resources/SF Symbols/Object & Tools.txt"),
        .process("Resources/SF Symbols/Shapes.txt"),
        .process("Resources/SF Symbols/Text Formatting.txt"),
        .process("Resources/SF Symbols/Time.txt"),
        .process("Resources/SF Symbols/Transportation.txt"),
        .process("Resources/SF Symbols/Weather.txt"),
      ]),
    .testTarget(
      name: "SymbolPickerTests",
      dependencies: ["SymbolPicker"]),
  ]
)
