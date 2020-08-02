//
//  Store.swift
//  SetGame
//
//  Created by user on 01.08.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import Foundation

class Store: NSObject, ObservableObject {
    
    var deck: [Card] = [] // 81 cards
    var cardsInGame: [Card] = [] // 12 or more cards
    var selectedCards: [Card] = []
    
    
    override init() {
        super.init()
        
        createNewGame()
        
        // TODO: потом сделать в .onAppear
        dealCards()
    }
    
    func createNewGame() {
        for shape in Card.ShapeType.all {
            for number in Card.ShapesNumber.all {
                for color in Card.ShapeColor.all {
                    for shading in Card.Shading.all {
                        deck.append(Card(id: UUID(), isSelected: false, isMatched: false, isMissMatched: false, shape: .oval, shading: shading, color: color, number: .three))
                    }
                }
            }
        }
        
        deck.shuffle()
    }
    
    func dealCards() {
        let numberOfCards = 3 //max(3, 12 - cardsInGame.count)
        
        for _ in 0..<numberOfCards {
            let card = deck.removeLast()
            cardsInGame.append(card)
        }
    }
    
}
