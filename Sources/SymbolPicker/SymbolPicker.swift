//
//  SymbolPicker.swift
//  
//
//  Created by Francis Feng on 2021/7/26.
//

import Cocoa

open class SymbolPicker {
  var text = "Hello World"
  
  public static func makeNewWindow(symbol: String, color: NSColor, delegate: SymbolPickerDelegate, title: String? = nil) -> NSWindow? {
    let storyboard = NSStoryboard.init(name: "Main", bundle: .module)
    if let controller = storyboard.instantiateInitialController() as? WindowController {
      controller.configureCurrentItem(symbol: symbol, color: color)
      controller.delegate = delegate
      if let title = title {
        controller.window?.title = title
      }
      return controller.window
    }
    return nil
  }
  
}
