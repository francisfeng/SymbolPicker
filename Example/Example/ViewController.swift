//
//  ViewController.swift
//  Example
//
//  Created by Francis Feng on 2026-06-09.
//

import Cocoa
import SymbolPicker

class ViewController: NSViewController {
  
  @IBOutlet weak var imageView: NSImageView!
  
  var symbolPickerWindowController: NSWindowController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func pick(_ sender: Any) {
    if let windowController = SymbolPicker.windowController(
      symbol: "",
      color: .labelColor,
      delegate: self,
      title: "Pick a symbol"),
       let iconSheet = windowController.window {
      self.symbolPickerWindowController = windowController
      self.view.window?.beginSheet(iconSheet) {
        [unowned self] _ in
        self.symbolPickerWindowController = nil
      }
    }
  }
}

extension ViewController: SymbolPickerDelegate {
  func symbolPicker(_ symbol: String, color: NSColor?) {
    imageView.image = NSImage(systemSymbolName: symbol, accessibilityDescription: nil)
    let sizeConf = NSImage.SymbolConfiguration(pointSize: 120, weight: .medium)
    imageView.symbolConfiguration = sizeConf
    if let color {
      imageView.contentTintColor = color
    }
  }
}
