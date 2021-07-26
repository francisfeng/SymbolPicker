//
//  SidebarViewController.swift
//  SFSymbolsPicker
//
//  Created by Francis Feng on 2021/5/4.
//

import AppKit

protocol SidebarController: AnyObject {
  func sidebarController(_ controller: SidebarViewController, node: Node)
}

class SidebarViewController: NSViewController, NSOutlineViewDelegate {
  @IBOutlet weak var outlineView: NSOutlineView!
  
  @IBOutlet var treeController: NSTreeController!
  
  weak var delegate: SidebarController?
  
  @objc dynamic var content = [AnyObject]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureDefaultSidebar()
    configureOutlineView()
  }
  
  func configureOutlineView() {
    outlineView.enclosingScrollView?.scrollerStyle = .overlay
    DispatchQueue.main.async {
      self.selectAllSidebarItem()
    }
  }
  
  func selectAllSidebarItem() {
    if outlineView.selectedRow != 0 {
      let index = IndexSet(integer: 0)
      outlineView.selectRowIndexes(index, byExtendingSelection: false)
    }
  }
  
  static func node(from item: Any) -> Node? {
    if let treeNode = item as? NSTreeNode, let node = treeNode.representedObject as? Node {
      return node
    } else {
      return nil
    }
  }
  
  func configureDefaultSidebar() {
    for category in Symbol.Category.allCases {
      let name = Symbol.name[category]!
      let symbolName = Symbol.categorySymbol[category]!
      let node = Node(name.localized, symbolName: symbolName, category: category)
      content.append(node)
    }
  }
  
  func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
    return false
  }
  
  func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
    return 24
  }
  
  func outlineView(_ outlineView: NSOutlineView,
                   viewFor tableColumn: NSTableColumn?,
                   item: Any) -> NSView? {
    let dataCell = NSUserInterfaceItemIdentifier.init("DataCell")
    if let node = SidebarViewController.node(from: item) {
      if let view = outlineView.makeView(
          withIdentifier: dataCell,
          owner: self) as? NSTableCellView {
        view.textField?.bind(.value,
                             to: view,
                             withKeyPath: "objectValue.value",
                             options: nil)
        view.imageView?.image = NSImage(node.symbolName)
        return view
      }
    }
    return nil
  }
  
  func outlineViewSelectionDidChange(_ notification: Notification) {
    let seletedRow = outlineView.item(atRow: outlineView.selectedRow)
    if let node = SidebarViewController.node(from: seletedRow ?? 0) {
      delegate?.sidebarController(self, node: node)
    }
  }
}

