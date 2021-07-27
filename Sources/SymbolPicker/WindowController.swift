//
//  SymbolPicker.swift
//  SymbolPicker
//
//  Created by Francis Feng on 2021/5/3.
//

import AppKit

protocol SearchField: AnyObject {
  func searchField(_ string: String)
}

open class WindowController: NSWindowController {
  
  @IBOutlet weak var searchField: NSSearchField!
  
  weak var delegate: SymbolPickerDelegate?
  
  private weak var searchFieldDelegate: SearchField?
  
  weak var collectionViewController: SymbolCollectionViewController?
  
  open override func windowDidLoad() {
    super.windowDidLoad()
    window?.title = "SFSymbols".localized
    configureSearch()
    configureDelegates()
  }
  
  deinit {
    print(#function, "Symbol Picker", window)
  }
  
  func configureCurrentItem(symbol: String, color: NSColor) {
    collectionViewController?.configureCurrentItem(symbol: symbol, color: color)
  }
  
  func configureSearch() {
    searchField.target = self
    searchField.action = #selector(searchToolbarItemAction(_:))
  }
  
  func configureDelegates() {
    if let splitViewController = window?.contentViewController as? SplitViewController,
       let sidebar = splitViewController.splitViewItems.first?.viewController as? SidebarViewController,
       let collections = splitViewController.splitViewItems.last?.viewController as? SymbolCollectionViewController {
      collections.pickerDelegate = self
      searchFieldDelegate = collections
      sidebar.delegate = collections
      collectionViewController = collections
      splitViewController.symbolCollectionViewController = collectionViewController
      collectionViewController?.collectionView.delegate = splitViewController
    }
  }
  
  @objc func searchToolbarItemAction(_ sender: NSSearchField) {
    if let text = sender.cell?.stringValue {
      searchFieldDelegate?.searchField(text)
    }
  }
}

extension WindowController: SymbolPickerDelegate {
  public func symbolPicker(_ symbol: String, color: NSColor?) {
    delegate?.symbolPicker(symbol, color: color)
  }
}
