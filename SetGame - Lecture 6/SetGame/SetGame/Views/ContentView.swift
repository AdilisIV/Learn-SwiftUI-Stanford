//
//  ContentView.swift
//  SetGame
//
//  Created by user on 31.07.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var store: Store
    
    var body: some View {
        HStack {
            ForEach(store.cardsInGame, id: \.id) { card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .padding()
        .foregroundColor(Color.orange)
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}



struct CardView: View {
    var card: Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
            if card.shape == .diamond {
                DiamondSymbols(shapesCount: card.number.rawValue)
                    .rotationEffect(Angle(degrees: 90), anchor: .center)
//                        .offset(x: -size.width*0.05, y: 0)7
            } else if card.shape == .squiggle {
                SquiggleSymbols(shapesCount: card.number.rawValue)
                    .rotationEffect(Angle(degrees: 90), anchor: .center)
            } else if card.shape == .oval {
                OvalSymbols(shapesCount: card.number.rawValue)
                    .rotationEffect(Angle(degrees: 90), anchor: .center)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store())
    }
}
