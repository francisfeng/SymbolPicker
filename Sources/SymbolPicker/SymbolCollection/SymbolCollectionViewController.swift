//
//  SymbolsCollectionViewController.swift
//  SymbolPicker
//
//  Created by Francis Feng on 2021/5/4.
//

import Cocoa

public protocol SymbolPickerDelegate: AnyObject {
  func symbolPicker(_ symbol: String, color: NSColor?)
}

class SymbolCollectionViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {
  
  @IBOutlet weak var collectionView: CollectionView!
  
  var originalSymbolsName: [String] = []
  var symbolsName: [String] = []
  var color: NSColor = .labelColor
  var isColorChanged = false
  var currentSymbolName: String? = nil
  var currentSelected: Set<IndexPath>?
  weak var pickerDelegate: SymbolPickerDelegate?
  weak var sidebarDelegate: SidebarController?
  
  @IBOutlet weak var titleField: NSTextField!
  @IBOutlet weak var searchField: NSSearchField!
  
  @IBOutlet weak var colorPanelButton: NSButton!
  var lastTypeTime = Date()
  var minimumTypeDuration: TimeInterval = 0.3
  var workItem: DispatchWorkItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
    collectionView.wantsLayer = true
    collectionView.delegate = self
    collectionView.enclosingScrollView?.scrollerStyle = .overlay
    collectionView.register(SymbolView.self, forItemWithIdentifier: .SymbolView)
    collectionView.allowsEmptySelection = false
    searchField.action = #selector(searchAction)
    colorPanelButton.action = #selector(showColorPancel)
    colorPanelButton.target = self
    setupLayout()
  }
  
  public func toggleColorPanelButton(_ isHidden: Bool) {
    colorPanelButton.isHidden = isHidden
  }
  
  override func viewDidDisappear() {
    super.viewDidDisappear()
    if NSColorPanel.shared.isVisible {
      NSColorPanel.shared.orderOut(self)
    }
  }
  
  func configureCurrentItem(symbol: String, color: NSColor) {
    self.currentSymbolName = symbol
    self.color = color
  }
  
  private func setupLayout() {
    collectionView.collectionViewLayout = gridLayout()
  }
  
  private func gridLayout() -> NSCollectionViewLayout {
    let spacing: CGFloat = 15
    let itemWidth: CGFloat = 44
    let itemHeight: CGFloat = 36
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth), heightDimension: .absolute(itemHeight))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(itemHeight))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    group.interItemSpacing = .flexible(spacing)
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = spacing
    section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
    
    let layout = NSCollectionViewCompositionalLayout(section: section)
    return layout
  }
  
  @objc func searchAction(_ sender: Any) {
    let text = searchField.stringValue
    self.workItem?.cancel()
    let workItem = DispatchWorkItem { [weak self] in
      self?.searchSymbol(text.lowercased())
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + minimumTypeDuration, execute: workItem)
    self.workItem = workItem
  }
  
  @objc func showColorPancel(_ sender: Any) {
    let colorPanel = NSColorPanel.shared
    colorPanel.setTarget(self)
    colorPanel.setAction(#selector(updateColor))
    colorPanel.makeKeyAndOrderFront(self)
    colorPanel.isContinuous = true
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
    let symbol = symbolsName[indexPath.item]
    
    if let symbolItem = collectionView.makeItem(withIdentifier: .SymbolView, for: indexPath) as? SymbolView {
      configureSymbol(symbolItem, symbol: symbol)
      return symbolItem
    }
    
    let symbolItem = SymbolView()
    configureSymbol(symbolItem, symbol: symbol)
    return symbolItem
  }
  
  func configureSymbol(_ view: SymbolView, symbol: String) {
    let configuration = NSImage.SymbolConfiguration(pointSize: 18, weight: .regular)
    let image = NSImage(symbol)?.withSymbolConfiguration(configuration)
    view.imageViewForSymbol.image = image
    view.imageViewForSymbol.contentTintColor = color
    view.imageViewForSymbol.toolTip = symbol
    view.viewController = self
    
    if symbol == currentSymbolName {
      view.isSelected = true
    }
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
    selectCurrentSymbolIfPossible()
  }
  
  func selectCurrentSymbolIfPossible() {
    if let name = currentSymbolName,
      let index = symbolsName.firstIndex(of: name) {
      
      let indexPath = IndexPath(item: index, section: 0)
      let set = Set([indexPath])
      
      currentSelected = set
      
      collectionView.selectItems(at: set, scrollPosition: .centeredVertically)
    }
  }
}

extension SymbolCollectionViewController {
  func searchSymbol(_ string: String) {
    if string.isEmpty {
      symbolsName = originalSymbolsName
    } else {
      symbolsName = originalSymbolsName.filter{$0.contains(string)}
    }
    collectionView.reloadData()
  }
}
