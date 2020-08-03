//
//  OvalSymbols.swift
//  SetGame
//
//  Created by user on 02.08.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import SwiftUI

struct OvalSymbols: View {
    
    var shapesCount: Int
    var shading: Card.Shading
    var shapeColor: Card.ShapeColor
    
    let xScale: CGFloat = 0.65
    let offsetBetweenShapes: CGFloat = 5.0
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                if self.shading == .striped {
                    self.drawOval(with: geometry.size)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("\(self.shapeColor.rawValue)"), .white]), startPoint: .top, endPoint: .bottom))
                        .opacity(0.5)
                } else {
                    self.drawOval(with: geometry.size)
                    .fill(Color("\(self.shapeColor.rawValue)"))
                }
            }
        }
    }
    
    func drawOval(with size: CGSize) -> some Shape {
        let width = min(size.width, size.height) * xScale
        let halfWidth = (0.220 * width) * 0.9
        let halfHeight = 0.510 * width
        let height = halfHeight / 1.8
        let radius = halfWidth * 0.9
        let yOffset = (size.height - height*0.2) / 2
        
        let contentWidth = (halfWidth * 2 * CGFloat(shapesCount)) + (offsetBetweenShapes * CGFloat(shapesCount-1))
        let xOffset = (min(size.width, size.height) - contentWidth) / 2
        
        var shapePath = Path { path in
            
            switch self.shapesCount {
            case 1:
                let center: CGPoint = CGPoint(x: xOffset + halfWidth, y: yOffset)
                path.addPath(getOvalPath(center: center, height: height, radius: radius))
            case 2:
                var center: CGPoint = CGPoint(x: xOffset + halfWidth, y: yOffset)
                var middle: CGFloat = xOffset + halfWidth
                path.addPath(getOvalPath(center: center, height: height, radius: radius))
                
                middle = middle + (halfWidth*2) + offsetBetweenShapes
                center = CGPoint(x: middle, y: yOffset)
                path.addPath(getOvalPath(center: center, height: height, radius: radius))
            case 3:
                var center: CGPoint = CGPoint(x: xOffset + halfWidth, y: yOffset)
                var middle: CGFloat = xOffset + halfWidth
                path.addPath(getOvalPath(center: center, height: height, radius: radius))
                
                middle = middle + (halfWidth*2) + offsetBetweenShapes
                center = CGPoint(x: middle, y: yOffset)
                path.addPath(getOvalPath(center: center, height: height, radius: radius))
                
                middle = middle + (halfWidth*2) + offsetBetweenShapes
                center = CGPoint(x: middle, y: yOffset)
                path.addPath(getOvalPath(center: center, height: height, radius: radius))
            default:
                break
            }
        }
        
        if shading == .outlined {
            shapePath = shapePath.strokedPath(.init(lineWidth: 5.0))
        }
        
        return shapePath
        
    }
    
    func getOvalPath(center: CGPoint, height: CGFloat, radius: CGFloat) -> Path {
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: center.x, y: center.y+height), radius: radius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 0), clockwise: true)
        path.addArc(center: CGPoint(x: center.x, y: center.y-height), radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)
        path.addLine(to: CGPoint(x: center.x-radius, y: center.y+height))
        
        return path
    }
}

struct OvalSymbols_Previews: PreviewProvider {
    static var previews: some View {
        OvalSymbols(shapesCount: 2, shading: .striped, shapeColor: .red)
    }
}
