//
//  SymbolPicker.swift
//  SymbolPicker
//
//  Created by Francis Feng on 2021/5/3.
//

import AppKit

open class WindowController: NSWindowController {
  
  @IBOutlet weak var searchField: NSSearchField?
  
  weak var delegate: SymbolPickerDelegate?
  
  weak var collectionViewController: SymbolCollectionViewController?
  
  open override func windowDidLoad() {
    super.windowDidLoad()
    updateWindowTitle("SF Symbols".localized)
    window?.isReleasedWhenClosed = true
    configureDelegates()
  }
  
  public func configureCurrentItem(symbol: String, color: NSColor) {
    collectionViewController?.configureCurrentItem(symbol: symbol, color: color)
  }
  
  public func toggleColorPanelButton(_ isHidden: Bool) {
    collectionViewController?.toggleColorPanelButton(isHidden)
  }
  
  public func updateWindowTitle(_ title: String) {
    collectionViewController?.titleField.stringValue = title
  }
  
  private func configureDelegates() {
    if let splitViewController = window?.contentViewController as? SplitViewController,
       let sidebar = splitViewController.splitViewItems.first?.viewController as? SidebarViewController,
       let collections = splitViewController.splitViewItems.last?.viewController as? SymbolCollectionViewController {
      collections.pickerDelegate = self
      sidebar.delegate = collections
      collectionViewController = collections
      splitViewController.symbolCollectionViewController = collectionViewController
      collectionViewController?.collectionView.delegate = splitViewController
    }
  }
  
  @IBAction func performFindPanelAction(_ sender: Any) {
    self.window?.makeFirstResponder(collectionViewController?.searchField)
  }
}

extension WindowController: SymbolPickerDelegate {
  public func symbolPicker(_ symbol: String, color: NSColor?) {
    delegate?.symbolPicker(symbol, color: color)
  }
}
