//
//  SymbolsCollectionViewController.swift
//  SFSymbolsPicker
//
//  Created by Francis Feng on 2021/5/4.
//

import Cocoa

public protocol SymbolPickerDelegate {
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
  var pickerDelegate: SymbolPickerDelegate?
  var sidebarDelegate: SidebarController?
  
  let nibIdentifier = NSUserInterfaceItemIdentifier.init("SymbolView")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    observeColorWellChange()
    let nib = NSNib(nibNamed: "SymbolView", bundle: .module)
    collectionView.register(nib, forItemWithIdentifier: nibIdentifier)
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
    if let selected = currentSelected {
      collectionView.selectItems(at: selected, scrollPosition: .centeredVertically)
    }
  }
  
  func numberOfSections(in collectionView: NSCollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return symbolsName.count
  }
  
  func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    let item = collectionView.makeItem(withIdentifier: nibIdentifier, for: indexPath)
    let symbol = symbolsName[indexPath.item]
    if let symbolItem = item as? SymbolView {
      if #available(macOS 11.0, *) {
        let configuration = NSImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        let image = NSImage(symbol)?.withSymbolConfiguration(configuration)
        symbolItem.imageView?.image = image
      }
      symbolItem.imageView?.contentTintColor = color
      symbolItem.imageView?.toolTip = symbol
      return symbolItem
    }
    return item
  }
  
  func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
    currentSelected = indexPaths
    guard let indexPath = indexPaths.first else { return }
    let symbol = symbolsName[indexPath.item]
    if isColorChanged {
      pickerDelegate?.symbolPicker(symbol, color: NSColorPanel.shared.color)
    } else {
      pickerDelegate?.symbolPicker(symbol, color: nil)
    }
    guard let window = view.window else { return }
    window.sheetParent?.endSheet(window, returnCode: .cancel)
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
      collectionView.selectItems(at: set, scrollPosition: .centeredVertically)
      collectionView.scrollToItems(at: set, scrollPosition: .centeredVertically)
      currentSelected = set
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
