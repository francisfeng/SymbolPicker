# Symbol Picker

A SF Symbols picker for Mac apps. Built with AppKit.

## Compatibility

- macOS 11.0+

## Install

Add `https://github.com/francisfeng/SymbolPicker` in the [“Swift Package Manager” tab in Xcode](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

## Usage

![screenshot of Symbol Picker](Images/screenshot.PNG)

1. AppKit
```swift

// in your NSViewController subclass
import SymbolPicker

@objc func pickIcon(_ sender: NSMenuItem) {
  if let windowController = SymbolPicker.windowController(
      symbol: collection.symbol,
      color: collection.color ?? .labelColor,
      delegate: self,
      title: collection.name),
     let iconSheet = windowController.window {
    
    // You need to persist this windowController in your app.
    symbolPickerWindowController = windowController
    
    window.beginSheet(iconSheet) {
      _ in
      self.symbolPickerWindowController = nil
    }
  }
}

extension ViewController: SymbolPickerDelegate {
  func symbolPicker(_ symbol: String, color: NSColor?) {
  
  }
}
```

2. SwiftUI

I haven't try it with SwiftUI yet. Any contributions will be welcome.

## Lisense
MIT
