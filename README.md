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

@objc func pickIcon(_ sender: Any) {
  if let windowController = SymbolPicker.windowController(
      symbol: selectedSFSymbol,
      color: symbolColor,
      delegate: self,
      title: windowTitleForTheSymbolPicker),
     let iconSheet = windowController.window {
    
    // You need to persist this windowController in your app.
    self.symbolPickerWindowController = windowController
    
    window.beginSheet(iconSheet) {
      [unowned self] _ in
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

Use the SwiftUI view like this:
```swift
SymbolPickerView(
    showSymbolPicker: $showSymbolPicker, 
    selectedSymbol: $selectedSymbol, 
    selectedColor: $selectedColor, 
    title: title
)
```
Where 
- `showSymbolPicker` is a `Bool` representing if the picker view is shown or not
- `selectedSymbol` is a `String` representing the SF symbol's name
- `selectedColor` is the `Color` of the object
- `title` is the name shown in the title bar of the popup window

## Lisense
MIT
