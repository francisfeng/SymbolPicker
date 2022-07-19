//
//  FieldEditor.swift
//  
//
//  Created by Francis Feng on 2022/7/19.
//

import Cocoa

class FieldEditor: NSTextView {
  var caretWidth: CGFloat = 2
  var caretColor = NSColor.labelColor.withAlphaComponent(0.7)
  
  private lazy var radius = caretWidth / 2
  private lazy var displayAdjustment = caretWidth - 1
  
  // Source: https://gist.github.com/importRyan/669999190f3b4db8e031c5971e7fa7ed
  open override func drawInsertionPoint(in rect: NSRect, color: NSColor, turnedOn flag: Bool) {

    var rect = rect
    rect.size.width = caretWidth

    let path = NSBezierPath(roundedRect: rect,
                            xRadius: radius,
                            yRadius: radius)
    path.setClip()

    super.drawInsertionPoint(in: rect,
                             color: caretColor,
                             turnedOn: flag)
  }

  open override func setNeedsDisplay(_ rect: NSRect, avoidAdditionalLayout flag: Bool) {
    var rect = rect
    rect.size.width += displayAdjustment
    super.setNeedsDisplay(rect, avoidAdditionalLayout: flag)
  }
}
