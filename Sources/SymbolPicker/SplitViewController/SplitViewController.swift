//
//  SplitViewController.swift
//  SymbolPicker
//
//  Created by Francis Feng on 2021/7/26.
//

import Cocoa

class SplitViewController: NSSplitViewController, NSCollectionViewDelegate {
  
  weak var symbolCollectionViewController: SymbolCollectionViewController?

  weak var pickerDelegate: SymbolPickerDelegate? {
    return symbolCollectionViewController?.pickerDelegate
  }
  
  var isColorChanged: Bool {
    return symbolCollectionViewController?.isColorChanged ?? false
  }
  
  var symbolsName: [String] {
    return symbolCollectionViewController!.symbolsName
  }
  
  func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
    symbolCollectionViewController?.currentSelected = indexPaths
    
    guard let indexPath = indexPaths.first else { return }
    guard let window = view.window else { return }
    
    let symbol = symbolsName[indexPath.item]
    if isColorChanged {
      pickerDelegate?.symbolPicker(symbol, color: NSColorPanel.shared.color)
    } else {
      pickerDelegate?.symbolPicker(symbol, color: nil)
    }
    symbolsCache.removeAllObjects()
    window.sheetParent?.endSheet(window, returnCode: .OK)
  }
  
}
