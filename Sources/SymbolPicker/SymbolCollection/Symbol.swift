//
//  Symbol.swift
//  SFSymbolsPicker
//
//  Created by Francis Feng on 2021/5/4.
//

import Foundation

class Symbol {
  enum Category: String, CaseIterable, Codable {
    case All = "All"
    case Communication = "Communication"
    case Weather = "Weather"
    case ObjectsTools = "Object & Tools"
    case Devices = "Devices"
    case Gaming = "Gaming"
    case Connectivity = "Connectivity"
    case Transportation = "Transportation"
    case Human = "Human"
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
  }
  
  static let name: [Category:String] = [
    .All: "CategoryAll",
    .Communication: "CategoryCommunication",
    .Weather: "CategoryWeather",
    .ObjectsTools: "CategoryObjectsTools",
    .Devices: "CategoryDevices",
    .Gaming: "CategoryGaming",
    .Connectivity: "CategoryConnectivity",
    .Transportation: "CategoryTransportation",
    .Human: "CategoryHuman",
    .Nature: "CategoryNature",
    .Editing: "CategoryEditing",
    .TextFormatting: "CategoryTextFormatting",
    .Media: "CategoryMedia",
    .Keyboard: "CategoryKeyboard",
    .Commerce: "CategoryCommerce",
    .Time: "CategoryTime",
    .Health: "CategoryHealth",
    .Shapes: "CategoryShapes",
    .Arrows: "CategoryArrows",
    .Indices: "CategoryIndices",
    .Math: "CategoryMath",
  ]
  
  static let categorySymbol: [Category:String] = [
    .All: "square.grid.2x2",
    .Communication: "message",
    .Weather: "cloud.sun",
    .ObjectsTools: "folder",
    .Devices: "desktopcomputer",
    .Gaming: "gamecontroller",
    .Connectivity: "antenna.radiowaves.left.and.right",
    .Transportation: "car.fill",
    .Human: "person.crop.circle",
    .Nature: "leaf",
    .Editing: "slider.horizontal.3",
    .TextFormatting: "textformat",
    .Media: "playpause",
    .Keyboard: "command",
    .Commerce: "cart",
    .Time: "timer",
    .Health: "staroflife",
    .Shapes: "square.on.circle",
    .Arrows: "arrow.right",
    .Indices: "a.circle",
    .Math: "x.squareroot",
  ]
  
  static func symbols(in category: Category) -> [String] {
    if let url = Bundle.main.url(forResource: category.rawValue, withExtension: "txt") {
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
