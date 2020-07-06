//
//  MemoryGame.swift
//  Memorize
//
//  Created by user on 04.07.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(id: pairIndex*2, isFaceUp: false, isMatched: false, content: content))
            cards.append(Card(id: pairIndex*2+1, isFaceUp: false, isMatched: false, content: content))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        
        if let choosenIndex = cards.firstIndex(matching: card), !cards[choosenIndex].isFaceUp, !cards[choosenIndex].isMatched {
            if let potentialMatchIndex = self.indexOfTheOneAndOnlyFaceUpCard {
                if cards[potentialMatchIndex].content == cards[choosenIndex].content {
                    cards[potentialMatchIndex].isMatched = true
                    cards[choosenIndex].isMatched = true
                }
                self.cards[choosenIndex].isFaceUp = true
            } else {
                self.indexOfTheOneAndOnlyFaceUpCard = choosenIndex
            }
            
//            self.cards[choosenIndex].isFaceUp = !(self.cards[choosenIndex].isFaceUp)
        }
    }
    
//    func index(of card: Card) -> Int {
//        for i in 0..<cards.count {
//            if self.cards[i].id == card.id {
//                return i
//            }
//        }
//
//        return 0 // TODO: bogus!
//    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
