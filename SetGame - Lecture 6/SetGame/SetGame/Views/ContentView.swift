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
        NavigationView {
            VStack {
                Grid(items: store.cardsInGame) { card in
                    CardView(card: card)
                        .onTapGesture {
                            self.store.chooseCard(card: card)
                        }
                    .padding(5)
                }
                Spacer()
                HStack {
                    Spacer()
                    Button("Deal 3 Cards") {
                        self.store.dealMoreCards()
                    }
                        .font(.title)
                        .foregroundColor(.blue)
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .padding()
            .foregroundColor(Color.orange)
            .navigationBarTitle(Text("Score: \(store.score)"), displayMode: .inline)
            .navigationBarItems(trailing: Button("New Game") {
                self.store.createNewGame()
            })
        }
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
            RoundedRectangle(cornerRadius: 10.0).fill(card.backgroundColor)
            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
            if card.shape == .diamond {
                DiamondSymbols(shapesCount: card.number.rawValue, shading: card.shading, shapeColor: card.color)
                    .rotationEffect(Angle(degrees: 90), anchor: .center)
            } else if card.shape == .squiggle {
                SquiggleSymbols(shapesCount: card.number.rawValue, shading: card.shading, shapeColor: card.color)
                    .rotationEffect(Angle(degrees: 90), anchor: .center)
            } else if card.shape == .oval {
                OvalSymbols(shapesCount: card.number.rawValue, shading: card.shading, shapeColor: card.color)
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
