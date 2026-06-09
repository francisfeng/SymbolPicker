//
//  Node.swift
//  SymbolPicker
//
//  Created by Francis Feng on 2021/5/4.
//

import AppKit

@objc class Node: NSObject, Codable {
  
  @objc var identifier: String = ""
  @objc let symbolName: String
  @objc let title: String
  let category: Symbol.Category
  
  @objc dynamic var children = [Node]()
  
  @objc dynamic var count: Int {
    return children.count
  }
  
  init(category: Symbol.Category) {
    self.title = category.title
    self.symbolName = category.symbol
    self.category = category
  }
  
  @objc dynamic var isLeaf: Bool {
    return children.isEmpty
  }
}

