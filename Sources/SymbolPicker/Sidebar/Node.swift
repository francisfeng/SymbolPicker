//
//  Node.swift
//  SFSymbolsPicker
//
//  Created by Francis Feng on 2021/5/4.
//

import AppKit

@objc class Node: NSObject, Codable {
  
  @objc var identifier: String = ""
  @objc let symbolName: String
  @objc let value: String
  let category: Symbol.Category
  
  @objc dynamic var children = [Node]()
  
  @objc dynamic var count: Int {
    return children.count
  }
  
  init(_ value: String, symbolName: String, category: Symbol.Category) {
    self.value = value
    self.symbolName = symbolName
    self.category = category
  }
  
  @objc dynamic var isLeaf: Bool {
    return children.isEmpty
  }
}

