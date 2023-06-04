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

    public func makeNSView(context: Context) -> SymbolPickerAdaptor {
        let adaptor = SymbolPickerAdaptor(
            title: title,
            color: .init(selectedColor),
            delegate: context.coordinator
        )
        return adaptor
    }

    public func updateNSView(_ nsView: SymbolPickerAdaptor, context: Context) {
        nsView.title = title
        nsView.color = NSColor(selectedColor)
        if showSymbolPicker {
            nsView.showPickIcon()
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
        }

        public func changeDisplayMode(showing: Bool) {
            parent.showSymbolPicker = showing
        }

        public func getCurrentSymbol() -> String {
            parent.selectedSymbol
        }
    }
}

public final class SymbolPickerAdaptor: NSView {
    var title: String
    var color: NSColor
    var delegate: any SymbolPickerDelegateSwiftUI

    private var symbolPickerWindowController: NSWindowController?

    init(title: String, color: NSColor, delegate: any SymbolPickerDelegateSwiftUI) {
        self.title = title
        self.color = color
        self.delegate = delegate
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showPickIcon() {
        guard let windowController = SymbolPicker.windowController(
            symbol: delegate.getCurrentSymbol(),
            color: self.color,
            delegate: delegate,
            title: self.title),
              let iconSheet = windowController.window,
              let window
        else {
            print("Oh no smth missing")
            return
        }

        // You need to persist this windowController in your app.
        self.symbolPickerWindowController = windowController
        print("Show pick icon!")

        window.beginSheet(iconSheet) { [weak self] _ in
            self?.delegate.changeDisplayMode(showing: false)
        }
    }
}

protocol SymbolPickerDelegateSwiftUI: SymbolPickerDelegate {
    func changeDisplayMode(showing: Bool)
    func getCurrentSymbol() -> String
}
