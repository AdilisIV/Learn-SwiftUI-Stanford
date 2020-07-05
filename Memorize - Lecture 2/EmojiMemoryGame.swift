//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by user on 04.07.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import Foundation

class EmojiMemoryGame {
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: [String] = ["👻", "🎃", "🕷", "💀", "🤠", "💸"]
        let pairsAmount = Int.random(in: 2...5)
        return MemoryGame(numberOfPairsOfCards: pairsAmount) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the model
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
