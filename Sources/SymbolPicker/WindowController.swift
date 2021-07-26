//
//  SymbolPicker.swift
//  SymbolPicker
//
//  Created by Francis Feng on 2021/5/3.
//

import AppKit

protocol SearchField {
  func searchField(_ string: String)
}

open class WindowController: NSWindowController {
  
  @IBOutlet weak var searchField: NSSearchField!
  
  var delegate: SymbolPickerDelegate?
  
  private var searchFieldDelegate: SearchField?
  
  open override func windowDidLoad() {
    super.windowDidLoad()
    window?.title = "SFSymbols".localized
    configureSearch()
    configureDelegates()
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
    }
  }
  
  @objc func searchToolbarItemAction(_ sender: NSSearchField) {
    if let text = sender.cell?.stringValue {
      searchFieldDelegate?.searchField(text)
    }
  }
}

extension WindowController: SymbolPickerDelegate {
  func symbolPicker(_ symbol: String, color: NSColor) {
    print(#function, symbol)
  }
}
