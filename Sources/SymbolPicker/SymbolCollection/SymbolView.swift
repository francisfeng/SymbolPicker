//
//  SymbolItem.swift
//  SFSymbolsPicker
//
//  Created by Francis Feng on 2021/5/4.
//

import AppKit

class SymbolView: NSCollectionViewItem {
  
  @IBOutlet weak var boxView: NSBox!
  
  override func loadView() {
    super.loadView()
    self.boxView.layer?.masksToBounds = true
  }
  
  override var isSelected: Bool {
    didSet {
      self.boxView.fillColor = isSelected ? .controlAccentColor.withAlphaComponent(0.75) : .clear
    }
  }
}
