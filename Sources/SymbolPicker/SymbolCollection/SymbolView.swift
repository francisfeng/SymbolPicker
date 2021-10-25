//
//  SymbolItem.swift
//  SymbolPicker
//
//  Created by Francis Feng on 2021/5/4.
//

import AppKit

extension NSUserInterfaceItemIdentifier {
  static let SymbolView = Self("SymbolView")
}

class SymbolView: NSCollectionViewItem {
  
  var boxView: NSBox!
  var imageViewForSymbol: NSImageView!
  
  let viewFrame = NSRect(x: 0, y: 0, width: 44, height: 36)
  
  weak var viewController: SymbolCollectionViewController?
  
  init() {
    super.init(nibName: nil, bundle: .module)
    view = NSView(frame: viewFrame)
    view.postsFrameChangedNotifications = false
    view.postsBoundsChangedNotifications = false
    view.wantsLayer = true
    addBoxView()
    addImageView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func mouseDown(with event: NSEvent) {
    if event.clickCount > 1 && isSelected {
      viewController?.selectCurrent()
    } else {
      super.mouseDown(with: event)
    }
  }
  
  override func loadView() {}
  
  override var isSelected: Bool {
    didSet {
      self.boxView.fillColor = isSelected ? NSColor.controlAccentColor.withAlphaComponent(0.25) : NSColor.clear
    }
  }
  
  func addBoxView() {
    let boxView = NSBox(frame: viewFrame)
    boxView.layer?.masksToBounds = true
    boxView.titlePosition = .noTitle
    boxView.cornerRadius = 12
    boxView.boxType = .custom
    boxView.borderColor = .separatorColor
    boxView.wantsLayer = true
    self.boxView = boxView
    view.addSubview(boxView)
  }
  
  func addImageView() {
    let imageView = NSImageView()
    self.imageViewForSymbol = imageView
    imageView.wantsLayer = true
    boxView.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      boxView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
      boxView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
    ])
  }
}
