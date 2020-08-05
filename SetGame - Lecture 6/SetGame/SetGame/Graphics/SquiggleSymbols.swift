//
//  SquiggleSymbols.swift
//  SetGame
//
//  Created by user on 02.08.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import SwiftUI

struct SquiggleSymbols: View {
    
    var shapesCount: Int
    var shading: Card.Shading
    var shapeColor: Card.ShapeColor
    
    let xScale: CGFloat = 0.65
    let offsetBetweenShapes: CGFloat = 5.0
    
    var gradient: Gradient {
        return Gradient(stops:
        [
         .init(color: Color("\(shapeColor.rawValue)"), location: 0.3),
         .init(color: Color("\(shapeColor.rawValue)"), location: 0.38),
         .init(color: .white, location: 0.4),
         .init(color: Color("\(shapeColor.rawValue)"), location: 0.42),
         .init(color: Color("\(shapeColor.rawValue)"), location: 0.48),
         .init(color: .white, location: 0.5),
         .init(color: Color("\(shapeColor.rawValue)"), location: 0.52),
         .init(color: Color("\(shapeColor.rawValue)"), location: 0.58),
         .init(color: .white, location: 0.6),
         .init(color: Color("\(shapeColor.rawValue)"), location: 0.62)
        ])
    }
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                if self.shading == .striped {
                    self.drawSquiggle(with: geometry.size)
                        .fill(LinearGradient(gradient: self.gradient, startPoint: .top, endPoint: .bottom))
                } else {
                    self.drawSquiggle(with: geometry.size)
                    .fill(Color("\(self.shapeColor.rawValue)"))
                }
            }
        }
    }
    
    private func drawSquiggle(with size: CGSize) -> Path {
        let width = min(size.width, size.height) * xScale
        let shapeSize = 0.220 * width
        let halfWidth = width * 0.170
        let halfHeight = 0.450 * width
        let yOffset = (size.height - halfHeight * 2) / 2
        
        let contentWidth = (halfWidth * 2 * CGFloat(shapesCount)) + (offsetBetweenShapes * CGFloat(shapesCount-1))
        let xOffset = (width - contentWidth) / 2
        
        var shapePath = Path { path in
            switch self.shapesCount {
            case 1:
                let center: CGPoint = CGPoint(x: xOffset + halfWidth, y: yOffset)
                path.addPath(getSquigglePath(with: shapeSize, center: center))
            case 2:
                var center: CGPoint = CGPoint(x: xOffset + halfWidth, y: yOffset)
                var middle: CGFloat = xOffset + halfWidth
                path.addPath(getSquigglePath(with: shapeSize, center: center))
                
                middle = middle + (halfWidth*2) + offsetBetweenShapes
                center = CGPoint(x: middle, y: yOffset)
                path.addPath(getSquigglePath(with: shapeSize, center: center))
            case 3:
                var center: CGPoint = CGPoint(x: xOffset + halfWidth, y: yOffset)
                var middle: CGFloat = xOffset + halfWidth
                path.addPath(getSquigglePath(with: shapeSize, center: center))
                
                middle = middle + (halfWidth*2) + offsetBetweenShapes
                center = CGPoint(x: middle, y: yOffset)
                path.addPath(getSquigglePath(with: shapeSize, center: center))
                
                middle = middle + (halfWidth*2) + offsetBetweenShapes
                center = CGPoint(x: middle, y: yOffset)
                path.addPath(getSquigglePath(with: shapeSize, center: center))
            default:
                break
            }
        }
        
        if shading == .outlined {
            shapePath = shapePath.strokedPath(.init(lineWidth: 5.0))
        }
        
        return shapePath
    }
    
    private func getSquigglePath(with size: CGFloat, center: CGPoint) -> Path {
        var path = Path()
        
        let sf = size / 29     // scale factor
        let dx = center.x// - (70*sf/2) + 0 // shift x
        let dy = center.y// - (size/2) + 50    // shift y
        
        path.move(to: CGPoint(x: 15*sf+dx, y: 104*sf+dy))
        path.addCurve(to: CGPoint(x: 54*sf+dx, y: 63*sf+dy), control1: CGPoint(x: 36.9*sf+dx, y: 112.4*sf+dy),
                      control2: CGPoint(x: 60.8*sf+dx, y: 89.7*sf+dy))
        path.addCurve(to: CGPoint(x: 53*sf+dx, y: 27*sf+dy), control1: CGPoint(x: 51.3*sf+dx, y: 52.3*sf+dy),
                      control2: CGPoint(x: 42*sf+dx, y: 42.2*sf+dy))
        path.addCurve(to: CGPoint(x: 40*sf+dx, y: 5*sf+dy), control1: CGPoint(x: 65.6*sf+dx, y: 9.6*sf+dy),
                      control2: CGPoint(x: 58.3*sf+dx, y: 5.4*sf+dy))
        path.addCurve(to: CGPoint(x: 12*sf+dx, y: 36*sf+dy), control1: CGPoint(x: 22*sf+dx, y: 4.6*sf+dy),
                      control2: CGPoint(x: 19.1*sf+dx, y: 9.7*sf+dy))
        path.addCurve(to: CGPoint(x: 14*sf+dx, y: 89*sf+dy), control1: CGPoint(x: 15.2*sf+dx, y: 59.2*sf+dy),
                      control2: CGPoint(x: 31.5*sf+dx, y: 61.9*sf+dy))
        path.addCurve(to: CGPoint(x: 15*sf+dx, y: 104*sf+dy), control1: CGPoint(x: 10*sf+dx, y: 95.3*sf+dy),
                      control2: CGPoint(x: 6.9*sf+dx, y: 100.9*sf+dy))
        
        return path
    }
}

struct SquiggleSymbols_Previews: PreviewProvider {
    static var previews: some View {
        SquiggleSymbols(shapesCount: 2, shading: .striped, shapeColor: .purple)
    }
}
