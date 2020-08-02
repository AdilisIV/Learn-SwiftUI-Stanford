//
//  DiamondShape.swift
//  SetGame
//
//  Created by user on 31.07.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import SwiftUI

struct DiamondShape: Shape {
    
    var center: CGPoint
    var middle: CGFloat
    var width: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let height = width * 0.75
        let halfWidth = 0.220 * width
        let halfHeight = 0.420 * height
        
        path.move(to: CGPoint(x: center.x, y: center.y + halfHeight))
        path.addLines([
            CGPoint(x: middle, y: 0),
            CGPoint(x: middle - halfWidth, y: halfHeight),
            CGPoint(x: middle, y: halfHeight * 2),
            CGPoint(x: middle + halfWidth, y: halfHeight),
            CGPoint(x: middle, y: 0)
        ])
        
        return path
    }
    
}

//struct CardSymbols: Shape {
//
//    var shape: ShapeType
//    var shapesCount: Int
//    var shading: Shading
//    var color: ShapeColor
//
//    func path(in rect: CGRect) -> Path {
//        let center = CGPoint(x: rect.midX, y: rect.midY)
//        var paths: [Path] = []
//        var getPath: (CGPoint, CGFloat) -> UIBezierPath
//
//        switch shape {
//        case .squiggle:
//            getPath = getDiamondPath
//        case .oval:
//            getPath = getDiamondPath
//        case .diamond:
//            getPath = getDiamondPath
//        }
//
//        return Path()
//    }
//
//    private func getDiamondPath(withCenter center: CGPoint, andSize size: CGFloat) -> UIBezierPath {
//
//        let width = size / 4.5
//        let halfHeight = size / 2
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: center.x, y: center.y - halfHeight))    // top
//        path.addLine(to: CGPoint(x: center.x + width, y: center.y)) // right
//        path.addLine(to: CGPoint(x: center.x, y: center.y + halfHeight)) // bottom
//        path.addLine(to: CGPoint(x: center.x - width, y: center.y)) // left
//        path.close()
//        return path
//    }
//}
//
//extension CardSymbols {
//
//    enum ShapeType {
//        case squiggle
//        case oval
//        case diamond
//    }
//
//    enum Shading {
//        case solid
//        case striped
//        case outlined
//    }
//
//    enum ShapeColor {
//        case red
//        case green
//        case purple
//    }
//}
