//
//  SymbolsCollectionViewController.swift
//  SFSymbolsPicker
//
//  Created by Francis Feng on 2021/5/4.
//

import Cocoa

public protocol SymbolPickerDelegate: AnyObject {
  func symbolPicker(_ symbol: String, color: NSColor?)
}

class SymbolCollectionViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {
  
  @IBOutlet weak var collectionView: NSCollectionView!
  
  var originalSymbolsName: [String] = []
  var symbolsName: [String] = []
  var color: NSColor = .labelColor
  var isColorChanged = false
  var currentSymbolName: String? = nil
  var currentSelected: Set<IndexPath>?
  weak var pickerDelegate: SymbolPickerDelegate?
  weak var sidebarDelegate: SidebarController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    observeColorWellChange()
  }
  
  func configureCurrentItem(symbol: String, color: NSColor) {
    self.currentSymbolName = symbol
    self.color = color
  }
  
  func observeColorWellChange() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(updateColor),
      name: NSColorPanel.colorDidChangeNotification, object: nil)
  }
  
  @objc func updateColor(sender: Any) {
    isColorChanged = true
    color = NSColorPanel.shared.color
    collectionView.reloadData()
    
    if let selected = currentSelected?.first {
      if let item = collectionView.item(at: selected) {
        item.isSelected = true
      }
    }
  }
  
  func numberOfSections(in collectionView: NSCollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return symbolsName.count
  }
  
  func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    let symbolItem = SymbolView()
    let symbol = symbolsName[indexPath.item]
    if #available(macOS 11.0, *) {
      let configuration = NSImage.SymbolConfiguration(pointSize: 18, weight: .regular)
      let image = NSImage(symbol)?.withSymbolConfiguration(configuration)
      symbolItem.imageViewForSymbol.image = image
    }
    symbolItem.imageViewForSymbol.contentTintColor = color
    symbolItem.imageViewForSymbol.toolTip = symbol
    symbolItem.viewController = self
    return symbolItem
  }
  
  // Used in SymbolView. Double-click to select current and exit.
  func selectCurrent() {
    let selectionIndexes = collectionView.selectionIndexes
    if let selected = selectionIndexes.first {
      let symbol = symbolsName[selected]
      if isColorChanged {
        pickerDelegate?.symbolPicker(symbol, color: NSColorPanel.shared.color)
      } else {
        pickerDelegate?.symbolPicker(symbol, color: nil)
      }
      guard let window = view.window else { return }
      window.sheetParent?.endSheet(window, returnCode: .OK)
    }
  }
  
}

extension SymbolCollectionViewController: SidebarController {
  func sidebarController(_ controller: SidebarViewController, node: Node) {
    symbolsName = Symbol.symbols(in: node.category)
    originalSymbolsName = Symbol.symbols(in: node.category)
    collectionView.reloadData()
    
    if let name = currentSymbolName,
      let index = originalSymbolsName.firstIndex(of: name) {
      
      let indexPath = IndexPath(item: index, section: 0)
      let set = Set([indexPath])
      
      currentSelected = set
      
      collectionView.selectItems(at: set, scrollPosition: .centeredVertically)
      
      // The above line scrolls to the right position,
      // but the item may not be selected.
      if let item = collectionView.item(at: indexPath) {
        item.isSelected = true
      }
     
    }
  }
}

extension SymbolCollectionViewController: SearchField {
  func searchField(_ string: String) {
    if string.isEmpty {
      symbolsName = originalSymbolsName
    } else {
      symbolsName = originalSymbolsName.filter{$0.contains(string)}
    }
    collectionView.reloadData()
  }
}
