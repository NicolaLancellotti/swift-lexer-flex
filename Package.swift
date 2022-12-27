// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swift-lexer-flex",
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.98
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .plugin(
      name: "FlexGenerator",
      capability: .command(
        intent: .custom(verb: "flex", description: "Generate flex files"),
        permissions: [
          .writeToPackageDirectory(reason: "This plugin generates flex files")
        ]
      )
    ),
    .target(
      name: "FlexLexer"
    ),
    .target(
      name: "Lexer",
      dependencies: ["FlexLexer"]),
    .testTarget(
      name: "LexerTests",
      dependencies: ["Lexer"]),
    .executableTarget(
      name: "Binary",
      dependencies: ["Lexer", "FlexLexer"],
      path: "Sources/Binary",
      resources: [.process("Resources/text.txt")])
  ]
)
