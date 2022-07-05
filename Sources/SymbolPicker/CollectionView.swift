//
//  CollectionView.swift
//  
//
//  Created by Francis on 2022/7/5.
//

import Cocoa

class CollectionView: NSCollectionView {
  // When user click the space area between icons in collection view,
  // CollectionView becomes the first responder. Thus the keyDown event
  // we override in Window can’t be called.
  //
  // To make “Esc to Close Sheet” work, we need to implement the same logic
  // in CollectionView.
  open override func keyDown(with event: NSEvent) {
    // 53 is the key code for Esc
    if event.keyCode == 53,
       let window = self.window {
      window.sheetParent?.endSheet(window, returnCode: .OK)
    } else {
      super.keyDown(with: event)
    }
  }
}
