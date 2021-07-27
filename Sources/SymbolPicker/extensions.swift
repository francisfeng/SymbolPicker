//
//  extensions.swift
//  SymbolPicker
//
//  Created by Francis Feng on 2021/5/4.
//

import Cocoa

extension String {
  var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: .module, value: "", comment: "")
  }
}

extension NSImage {
  convenience init?(_ name: String) {
    if #available(macOS 11.0, *) {
      self.init(systemSymbolName: name, accessibilityDescription: nil)
    } else {
      self.init(named: name)
    }
  }
}

extension Date {
  static func - (lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
  }
}
