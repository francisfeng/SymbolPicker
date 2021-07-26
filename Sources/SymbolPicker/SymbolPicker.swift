//
//  SymbolPicker.swift
//  
//
//  Created by Francis Feng on 2021/7/26.
//

import Cocoa

open class SymbolPicker {
  var text = "Hello World"
  
  static func makeNewWindow() -> NSWindow? {
    let storyboard = NSStoryboard.init(name: "Main", bundle: nil)
    if let controller = storyboard.instantiateInitialController() as? NSWindowController {
      return controller.window
    }
    return nil
  }
  
}
