//
//  SymbolItem.swift
//  SFSymbolsPicker
//
//  Created by Francis Feng on 2021/5/4.
//

import AppKit

class SymbolView: NSCollectionViewItem {
  
  @IBOutlet weak var boxView: NSBox!
  
  weak var viewController: SymbolCollectionViewController?
  
  override func mouseDown(with event: NSEvent) {
    if event.clickCount > 1 && isSelected {
      viewController?.selectCurrent()
    } else {
      super.mouseDown(with: event)
    }
  }
  
  override func loadView() {
    super.loadView()
    self.boxView.layer?.masksToBounds = true
  }
  
  override var isSelected: Bool {
    didSet {
      self.boxView.fillColor = isSelected ? .controlAccentColor.withAlphaComponent(0.25) : .clear
    }
  }
}
