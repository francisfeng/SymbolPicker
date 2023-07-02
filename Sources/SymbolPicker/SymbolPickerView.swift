//
//  SymbolPIckerView.swift
//  
//
//  Created by Kai Quan Tay on 4/6/23.
//

import Foundation
import SwiftUI

@available(macOS 12.0, *)
public struct SymbolPickerView: NSViewRepresentable {
  @Binding var showSymbolPicker: Bool
  @Binding var selectedSymbol: String
  @Binding var selectedColor: Color
  
  var title: String = ""
  var showColorPickerItem: Bool
  
  public init(showSymbolPicker: Binding<Bool>, selectedSymbol: Binding<String>, selectedColor: Binding<Color>, title: String, showColorPickerItem: Bool) {
    self._showSymbolPicker = showSymbolPicker
    self._selectedSymbol = selectedSymbol
    self._selectedColor = selectedColor
    self.title = title
    self.showColorPickerItem = showColorPickerItem
  }
  
  public func makeNSView(context: Context) -> SymbolPickerAdaptor {
    let adaptor = SymbolPickerAdaptor(
      title: title,
      color: .init(selectedColor),
      showColorPickerItem: showColorPickerItem,
      delegate: context.coordinator
    )
    return adaptor
  }
  
  public func updateNSView(_ nsView: SymbolPickerAdaptor, context: Context) {
    nsView.title = title
    nsView.color = NSColor(selectedColor)
    if !showSymbolPicker {
      nsView.detach()
    }
  }
  
  public typealias NSViewControllerType = SymbolPickerAdaptor
  public typealias Coordinator = SymbolCoordinator
  
  public func makeCoordinator() -> SymbolCoordinator {
    SymbolCoordinator(parent: self)
  }
  
  public class SymbolCoordinator: NSObject, SymbolPickerDelegateSwiftUI {
    var parent: SymbolPickerView
    
    init(parent: SymbolPickerView) {
      self.parent = parent
    }
    
    public func symbolPicker(_ symbol: String, color: NSColor?) {
      parent.selectedSymbol = symbol
      if let color {
        parent.selectedColor = .init(nsColor: color)
      } else {
        parent.selectedColor = .accentColor
      }
      parent.showSymbolPicker = false
    }
    
    public func changeDisplayMode(showing: Bool) {
      parent.showSymbolPicker = showing
    }
    
    public func getCurrentSymbol() -> String {
      return parent.selectedSymbol
    }
  }
}

public final class SymbolPickerAdaptor: NSView {
  var title: String
  var color: NSColor
  var showColorPickerItem: Bool
  var delegate: any SymbolPickerDelegateSwiftUI
  
  private var symbolPickerWindowController: NSWindowController?
  
  init(title: String, color: NSColor, showColorPickerItem: Bool, delegate: any SymbolPickerDelegateSwiftUI) {
    self.title = title
    self.color = color
    self.showColorPickerItem = showColorPickerItem
    self.delegate = delegate
    super.init(frame: .zero)
    self.addPickerView()
  }
  
  public func detach() {
    symbolPickerWindowController = nil
  }

  private func addPickerView() {
    if let windowController = SymbolPicker.windowController(
      symbol: delegate.getCurrentSymbol(),
      color: self.color,
      delegate: delegate,
      title: self.title,
      showColorPickerItem: self.showColorPickerItem) {
      windowController.loadWindow()
      if let view = windowController.window?.contentView {
        self.symbolPickerWindowController = windowController
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          self.topAnchor.constraint(equalTo: view.topAnchor),
          self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

protocol SymbolPickerDelegateSwiftUI: SymbolPickerDelegate {
  func changeDisplayMode(showing: Bool)
  
  func getCurrentSymbol() -> String
}
