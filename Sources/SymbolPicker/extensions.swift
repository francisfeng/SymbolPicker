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
    self.init(systemSymbolName: name, accessibilityDescription: nil)
  }
}

extension Date {
  static func - (lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
  }
}
