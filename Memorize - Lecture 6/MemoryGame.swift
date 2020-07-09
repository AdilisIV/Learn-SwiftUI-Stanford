//
//  MemoryGame.swift
//  Memorize
//
//  Created by user on 04.07.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    private(set) var theme: GameTheme
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    
    init(theme: GameTheme, numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        self.theme = theme
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(id: pairIndex*2, isFaceUp: false, isMatched: false, isAlreadyViewed: false, content: content))
            cards.append(Card(id: pairIndex*2+1, isFaceUp: false, isMatched: false, isAlreadyViewed: false, content: content))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        
        if let choosenIndex = cards.firstIndex(matching: card), !cards[choosenIndex].isFaceUp, !cards[choosenIndex].isMatched {
            if let potentialMatchIndex = self.indexOfTheOneAndOnlyFaceUpCard {
                if cards[potentialMatchIndex].content == cards[choosenIndex].content {
                    cards[potentialMatchIndex].isMatched = true
                    cards[choosenIndex].isMatched = true
                    
                    score += 2
                } else {
                    score -= cards[potentialMatchIndex].isAlreadyViewed ? 1 : 0
                    score -= cards[choosenIndex].isAlreadyViewed ? 1 : 0
                    
                    cards[potentialMatchIndex].isAlreadyViewed = true
                    cards[choosenIndex].isAlreadyViewed = true
                }
                self.cards[choosenIndex].isFaceUp = true
            } else {
                self.indexOfTheOneAndOnlyFaceUpCard = choosenIndex
            }
            
        }
    }
    
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool
        var isMatched: Bool
        var isAlreadyViewed: Bool
        var content: CardContent
    }
    
    struct GameTheme {
        enum Name: String {
            case halloween = "Halloween"
            case animals = "Animals"
            case sports = "Sports"
            case faces = "Faces"
        }

        enum FillColor: String {
            case orange = "F2AAAA"
            case yellow = "FBD46D"
            case green = "9BDEAC"
            case blue = "A6DCEF"
        }

        var name: Name
        var emojiSet: [CardContent]
        var numberOfPairsOfCards: Int?
        var fillColor: FillColor
    }
}
