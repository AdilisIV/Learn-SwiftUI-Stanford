//
//  Card.swift
//  SetGame
//
//  Created by user on 01.08.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import Foundation
import SwiftUI

struct Card: Identifiable {
    var id: UUID
    var isSelected: Bool
    var isMatched: Bool
    var isMissMatched: Bool
    var shape: ShapeType
    var shading: Shading
    var color: ShapeColor
    var backgroundColor: Color {
        if self.isSelected {
            return Color.appColors.selected
        } else if self.isMissMatched {
            return Color.appColors.mismatch
        } else if self.isMatched {
            return Color.appColors.match
        }
        return Color.white
    }
    var number: ShapesNumber
    
    
//    init(id: UUID, isSelected: Bool, isMatched: Bool, isMissMatched: Bool, shape: ShapeType, shading: Shading, color: ShapeColor, number: ShapesNumber) {
//        self.id = id
//        self.isSelected = isSelected
//        self.isMatched = isMatched
//        self.isMissMatched = isMissMatched
//        self.shape = shape
//        self.shading = shading
//        self.color = color
//        self.number = number
//    }
    
//    mutating func setMismatch() {
//        self.isMissMatched = true
//    }
    
    mutating func unsetMismatch() {
        self.isMissMatched = false
    }
}

extension Card {
    enum ShapeType {
        case squiggle
        case oval
        case diamond
        
        static var all = [squiggle, oval, diamond]
    }
    
    enum Shading {
        case solid
        case striped
        case outlined
        
        static var all = [solid, striped, outlined]
    }
    
    enum ShapeColor: String {
        case red = "SetRed"
        case green = "SetGreen"
        case purple = "SetPurple"
        
        static var all = [red, green, purple]
    }
    
    enum ShapesNumber: Int {
        case one = 1
        case two = 2
        case three = 3
        
        static var all = [one, two, three]
    }
}


extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id &&
            lhs.shape == rhs.shape &&
            lhs.color == rhs.color &&
            lhs.number == rhs.number &&
            lhs.shading == rhs.shading
    }
}

extension Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//extension Set where Element == Card {
//    subscript(_ value: Element) -> Element {
//        
//    }
//}
