//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by user on 04.07.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static var themes: [MemoryGame<String>.GameTheme] {
        return [
            .init(name: .halloween, emojiSet: ["👻", "🎃", "🕷", "💀", "🤠", "💸"], numberOfPairsOfCards: nil, fillColor: .orange),
            .init(name: .faces, emojiSet: ["😄", "😍", "🤓", "👩‍🦳"], numberOfPairsOfCards: 4, fillColor: .green),
            .init(name: .sports, emojiSet: ["🎾", "⛸", "🏊‍♂️", "🤸‍♀️", "🏇"], numberOfPairsOfCards: 5, fillColor: .blue),
            .init(name: .animals, emojiSet: ["🦁", "🐹", "🐧", "🙉"], numberOfPairsOfCards: 4, fillColor: .blue)
        ]
    }
    
    
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let theme: MemoryGame<String>.GameTheme = themes[Int.random(in: 1..<themes.count)]
        let pairsAmount = theme.numberOfPairsOfCards == nil ? Int.random(in: 2..<theme.emojiSet.count) : theme.numberOfPairsOfCards!
        
        return MemoryGame(theme: theme, numberOfPairsOfCards: pairsAmount) { pairIndex in
            return theme.emojiSet[pairIndex]
        }
    }
    
    private static func createRandomTheme() -> MemoryGame<String>.GameTheme {
        return themes[Int.random(in: 1..<themes.count)]
    }
    
    // MARK: - Access to the model
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    var currentScore: Int {
        return model.score
    }
    
    var currentTheme: MemoryGame<String>.GameTheme {
        model.theme
    }
    
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func onStartNewGameTap() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
