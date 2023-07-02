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

The `SymbolPicker` is designed to show as a sheet window.

In SwiftUI, you can present a sheet window with the `sheet` modifier of `Button` like this:

```swift

@State var showSymbolPicker = false
@State var commandIcon = "tray"
@State var selectedColor = Color.accentColor

Button(action: {
  showSymbolPicker = true
}, label: {
  Image(systemName: commandIcon)
}).sheet(isPresented: $showSymbolPicker) {
  SymbolPickerView(
    showSymbolPicker: $showSymbolPicker,
    selectedSymbol: $commandIcon,
    selectedColor: $selectedColor,
    title: "Command Icon",
    showColorPickerItem: false
  ).frame(minWidth: 550, maxWidth: 1920, minHeight: 320, maxHeight: 960)
}

// Keep `minWidth` and `minHeight` to `550` and `320` respectively
// because how the SymbolPicker is designed.
```
Where 
- `showSymbolPicker`: if we want to show the symbol picker.
- `selectedSymbol`: the name of the SF Symbol.
- `selectedColor`: the color the SF Symbol.
- `title`: the title of the symbol picker sheet window.
- `showColorPickerItem`: if we want to show the color picker toolbar item.

## Lisense
MIT
