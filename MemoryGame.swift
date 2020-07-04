//
//  MemoryGame.swift
//  Memorize
//
//  Created by user on 04.07.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(id: pairIndex*2, isFaceUp: true, isMatched: false, content: content))
            cards.append(Card(id: pairIndex*2+1, isFaceUp: false, isMatched: false, content: content))
        }
    }
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
