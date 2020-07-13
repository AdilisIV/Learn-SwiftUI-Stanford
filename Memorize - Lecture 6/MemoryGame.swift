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
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool {
            didSet {
                stopUsingBonusTime()
            }
        }
        var isAlreadyViewed: Bool
        var content: CardContent
        
        
        // MARK: - Bonus Time
        
        // this could give matching bonus time
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and still face up)
        var lastFaceUpDate: Date?
        // accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percentage of bonus time remaining
        var bonusRemaining: TimeInterval {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // whether we are currently face up, unmatched and have not yet used up the bonus time window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitins to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back to face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
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
