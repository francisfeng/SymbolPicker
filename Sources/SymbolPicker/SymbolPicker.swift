//
//  SymbolPicker.swift
//  
//
//  Created by Francis Feng on 2021/7/26.
//

import Cocoa

open class SymbolPicker {
  var text = "Hello World"
  
  public static func windowController(symbol: String, color: NSColor, delegate: SymbolPickerDelegate, title: String? = nil) -> NSWindowController? {
    let storyboard = NSStoryboard.init(name: "SymbolPicker", bundle: .module)
    if let controller = storyboard.instantiateController(withIdentifier: .init("main")) as? WindowController {
      controller.configureCurrentItem(symbol: symbol, color: color)
      controller.delegate = delegate
      if let title = title {
        controller.updateWindowTitle(title)
      }
      return controller
    }
    return nil
  }
  
}
