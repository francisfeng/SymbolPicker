//
//  Window.swift
//  
//
//  Created by Francis on 2021/7/27.
//

import Cocoa

class Window: NSWindow {
  open override func keyDown(with event: NSEvent) {
    // 53 is the key code for Esc
    if event.keyCode == 53 {
      self.sheetParent?.endSheet(self, returnCode: .OK)
    }
  }
}
