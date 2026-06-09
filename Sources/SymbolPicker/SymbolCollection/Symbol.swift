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
    case Maps = "Maps"
    case ObjectsTools = "Objects & Tools"
    case Devices = "Devices"
    case CameraPhotos = "Camera & Photos"
    case Gaming = "Gaming"
    case Connectivity = "Connectivity"
    case Transportation = "Transportation"
    case Automotive = "Automotive"
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
      
      if #available(macOS 14.0, *) {
        return categories
      } else if #available(macOS 13.0, *) {
        return categories.filter{!$0.isSonomaOnly}
      } else {
        return categories.filter{!$0.isSonomaOnly && !$0.isVenturaOnly}
      }
    }()
    
    var isSonomaOnly: Bool {
      switch self {
        case .Maps,
            .Automotive:
          return true
        default:
          return false
      }
    }
    
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
    
    var title: String {
      switch self {
        case .All:
          return String(localized: "All", bundle: .module)
        case .Communication:
          return String(localized: "Communication", bundle: .module)
        case .Weather:
          return String(localized: "Weather", bundle: .module)
        case .Maps:
          return String(localized: "Maps", bundle: .module)
        case .ObjectsTools:
          return String(localized: "Objects & Tools", bundle: .module)
        case .Devices:
          return String(localized: "Devices", bundle: .module)
        case .CameraPhotos:
          return String(localized: "Camera & Photos", bundle: .module)
        case .Gaming:
          return String(localized: "Gaming", bundle: .module)
        case .Connectivity:
          return String(localized: "Connectivity", bundle: .module)
        case .Transportation:
          return String(localized: "Transportation", bundle: .module)
        case .Automotive:
          return String(localized: "Automotive", bundle: .module)
        case .Accessibility:
          return String(localized: "Accessibility", bundle: .module)
        case .PrivacySecurity:
          return String(localized: "Privacy & Security", bundle: .module)
        case .Human:
          return String(localized: "Human", bundle: .module)
        case .Home:
          return String(localized: "Home", bundle: .module)
        case .Fitness:
          return String(localized: "Fitness", bundle: .module)
        case .Nature:
          return String(localized: "Nature", bundle: .module)
        case .Editing:
          return String(localized: "Editing", bundle: .module)
        case .TextFormatting:
          return String(localized: "Text Formatting", bundle: .module)
        case .Media:
          return String(localized: "Media", bundle: .module)
        case .Keyboard:
          return String(localized: "Keyboard", bundle: .module)
        case .Commerce:
          return String(localized: "Commerce", bundle: .module)
        case .Time:
          return String(localized: "Time", bundle: .module)
        case .Health:
          return String(localized: "Health", bundle: .module)
        case .Shapes:
          return String(localized: "Shapes", bundle: .module)
        case .Arrows:
          return String(localized: "Arrows", bundle: .module)
        case .Indices:
          return String(localized: "Indices", bundle: .module)
        case .Math:
          return String(localized: "Math", bundle: .module)
      }
    }
    
    var symbol: String {
      switch self {
        case .All:
          return "square.grid.2x2"
        case .Communication:
          return "message"
        case .Weather:
          return "cloud.sun"
        case .Maps:
          return "map"
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
        case .Automotive:
          return "steeringwheel"
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
    
    if #available(macOS 26.0, *) {
      prefix = "macOS26-"
    } else if #available(macOS 15.0, *) {
      prefix = "macOS15-"
    } else if #available(macOS 14.0, *) {
      prefix = "macOS14-"
    } else if #available(macOS 13.0, *) {
      prefix = "macOS13-"
    } else {
      prefix = "macOS12-"
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
