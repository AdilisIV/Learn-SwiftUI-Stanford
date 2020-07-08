//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by user on 03.07.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
            NavigationView {
                VStack {
                    Grid(items: viewModel.cards) { card in
                        CardView(card: card).onTapGesture {
                            self.viewModel.choose(card: card)
                        }
                        .padding(5)
                    }
                    Spacer()
                    Text("Score: \(viewModel.currentScore)")
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .padding()
                .foregroundColor(Color.hex(viewModel.currentTheme.fillColor.rawValue))
                .navigationBarTitle("\(viewModel.currentTheme.name.rawValue)", displayMode: .inline)
                .navigationBarItems(trailing: Button("New Game") {
                    self.viewModel.onStartNewGameTap()
                })
        }
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.75
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
