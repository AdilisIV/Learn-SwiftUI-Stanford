//
//  CardSymbol.swift
//  SetGame
//
//  Created by user on 01.08.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import SwiftUI

struct DiamondSymbols: View {
    
    var shapesCount: Int
    var shading: Card.Shading
    var shapeColor: Card.ShapeColor
    
    var xScale: CGFloat = 0.65
    let offsetBetweenShapes: CGFloat = 8.0
    
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
                    self.drawDiamond(with: geometry.size)
                        .fill(LinearGradient(gradient: self.gradient, startPoint: .top, endPoint: .bottom))
                } else {
                    self.drawDiamond(with: geometry.size)
                        .fill(Color("\(self.shapeColor.rawValue)"))
                }
            }
        }
    }
    
    private func drawDiamond(with size: CGSize) -> Path {
        print("SIZE: \(size)")
        let factor = min(size.width, size.height)*0.0055
        print("FACTOR: \(factor)")
        let width = min(size.width, size.height) * factor
        let halfWidth = 0.190 * width
        let halfHeight = 0.500 * width
        let yOffset = (size.height - halfHeight * 2) / 2
        
        let contentWidth = (halfWidth * 2 * CGFloat(shapesCount)) + (offsetBetweenShapes * CGFloat(shapesCount-1))
        let xOffset = (min(size.width, size.height) - contentWidth) / 2
        
        var shapePath = Path { path in
            
            switch self.shapesCount {
            case 1:
                let center: CGPoint = CGPoint(x: xOffset + halfWidth, y: yOffset)
                path.addPath(getDiamondPath(center: center, halfWidth: halfWidth, halfHeight: halfHeight))
            case 2:
                var center: CGPoint = CGPoint(x: xOffset + halfWidth, y: yOffset)
                var middle: CGFloat = xOffset + halfWidth
                path.addPath(getDiamondPath(center: center, halfWidth: halfWidth, halfHeight: halfHeight))
                
                middle = middle + (halfWidth*2) + offsetBetweenShapes
                center = CGPoint(x: middle, y: yOffset)
                path.addPath(getDiamondPath(center: center, halfWidth: halfWidth, halfHeight: halfHeight))
            case 3:
                var center: CGPoint = CGPoint(x: xOffset + halfWidth, y: yOffset)
                var middle: CGFloat = xOffset + halfWidth
                path.addPath(getDiamondPath(center: center, halfWidth: halfWidth, halfHeight: halfHeight))
                
                middle = middle + (halfWidth*2) + offsetBetweenShapes
                center = CGPoint(x: middle, y: yOffset)
                path.addPath(getDiamondPath(center: center, halfWidth: halfWidth, halfHeight: halfHeight))
                
                middle = middle + (halfWidth*2) + offsetBetweenShapes
                center = CGPoint(x: middle, y: yOffset)
                path.addPath(getDiamondPath(center: center, halfWidth: halfWidth, halfHeight: halfHeight))
            default:
                break
            }
        }
        
        if shading == .outlined {
            shapePath = shapePath.strokedPath(.init(lineWidth: 4.0))
        }
        
        return shapePath
    }
    
    private func getDiamondPath(center: CGPoint, halfWidth: CGFloat, halfHeight: CGFloat) -> Path {
        
        var path = Path()
        
        path.move(to: CGPoint(x: center.x, y: center.y - halfHeight))
        path.addLines([
            CGPoint(x: center.x, y: center.y + 0),
            CGPoint(x: center.x - halfWidth, y: center.y + halfHeight),
            CGPoint(x: center.x, y: center.y + halfHeight * 2),
            CGPoint(x: center.x + halfWidth, y: center.y + halfHeight),
            CGPoint(x: center.x, y: center.y + 0)
        ])
        
        return path
    }
}

struct DiamondSymbols_Previews: PreviewProvider {
    static var previews: some View {
        DiamondSymbols(shapesCount: 3, shading: .outlined, shapeColor: .green)
            .previewLayout(.fixed(width: 117.5, height: 165.0))
    }
}
