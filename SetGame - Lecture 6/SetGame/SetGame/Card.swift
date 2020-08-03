//
//  Card.swift
//  SetGame
//
//  Created by user on 01.08.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import Foundation

struct Card: Identifiable {
    var id: UUID
    var isSelected: Bool
    var isMatched: Bool
    var isMissMatched: Bool
    var shape: ShapeType
    var shading: Shading
    var color: ShapeColor
    var number: ShapesNumber
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
