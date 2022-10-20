//
//  Symbol.swift
//  SymbolPicker
//
//  Created by Francis Feng on 2021/5/4.
//

import Foundation

class Symbol {
  enum Category: String, CaseIterable, Codable {
    case All = "All"
    case Communication = "Communication"
    case Weather = "Weather"
    case ObjectsTools = "Objects & Tools"
    case Devices = "Devices"
    case CameraPhotos = "Camera & Photos"
    case Gaming = "Gaming"
    case Connectivity = "Connectivity"
    case Transportation = "Transportation"
    case Accessibility = "Accessibility"
    case PrivacySecurity = "Privacy & Security"
    case Human = "Human"
    case Home = "Home"
    case Fitness = "Fitness"
    case Nature = "Nature"
    case Editing = "Editing"
    case TextFormatting = "Text Formatting"
    case Media = "Media"
    case Keyboard = "Keyboard"
    case Commerce = "Commerce"
    case Time = "Time"
    case Health = "Health"
    case Shapes = "Shapes"
    case Arrows = "Arrows"
    case Indices = "Indices"
    case Math = "Math"
    
    static let all: [Category] = {
      var categories = Category.allCases
     
      if #available(macOS 13.0, *) {
       return categories
      } else {
        return categories.filter{!$0.isVenturaOnly}
      }
    }()
    
    var isVenturaOnly: Bool {
      switch self {
      case .CameraPhotos,
          .Accessibility,
          .PrivacySecurity,
          .Home,
          .Fitness:
        return true
      default:
        return false
      }
    }
    
    var name: String {
      return self.rawValue.localized
    }
    
    var symbol: String {
      switch self {
      case .All:
        return "square.grid.2x2"
      case .Communication:
        return "message"
      case .Weather:
        return "cloud.sun"
      case .ObjectsTools:
        return "folder"
      case .Devices:
        return "desktopcomputer"
      case .CameraPhotos:
        return "camera"
      case .Gaming:
        return "gamecontroller"
      case .Connectivity:
        return "antenna.radiowaves.left.and.right"
      case .Transportation:
        return "car.fill"
      case .Accessibility:
        return "figure.arms.open"
      case .PrivacySecurity:
        return "lock"
      case .Human:
        return "person.crop.circle"
      case .Home:
        return "house"
      case .Fitness:
        return "figure.run"
      case .Nature:
        return "leaf"
      case .Editing:
        return "slider.horizontal.3"
      case .TextFormatting:
        return "textformat"
      case .Media:
        return "playpause"
      case .Keyboard:
        return "command"
      case .Commerce:
        return "cart"
      case .Time:
        return "timer"
      case .Health:
        return "staroflife"
      case .Shapes:
        return "square.on.circle"
      case .Arrows:
        return "arrow.right"
      case .Indices:
        return "a.circle"
      case .Math:
        return "x.squareroot"
      }
    }
  }
  
  static func symbols(in category: Category) -> [String] {
    let prefix: String
    
    if #available(macOS 13.0, *) {
      prefix = "Ventura-"
    } else if #available(macOS 12.0, *) {
      prefix = "Monterey-"
    } else {
      prefix = "BigSur-"
    }
    
    if let url = Bundle.module.url(forResource: prefix + category.rawValue, withExtension: "txt") {
      do {
        let content = try String(contentsOf: url)
        let symbols = content.components(separatedBy: "\n").filter { !$0.isEmpty }
        return symbols
      } catch {
        return []
      }
    } else {
      return []
    }
  }
}
