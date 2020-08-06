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
    @Published var cardsInGame: [Card] = [] // 12 or more cards
    @Published var score: Int = 0
    
//    private var selectedCards: Set<Int> = Set()
    
    @Published var hasMatch: Bool = false
    var selected: [Int] = []
    
    
    override init() {
        super.init()
        
        startGame()
        
        // TO-DO: later do it on .onAppear
        dealMoreCards()
    }
    
    var isDeckEmpty: Bool {
        return deck.count <= 0
    }
    
    private func startGame() {
        for shape in Card.ShapeType.all {
            for number in Card.ShapesNumber.all {
                for color in Card.ShapeColor.all {
                    for shading in Card.Shading.all {
                        deck.append(Card(id: UUID(), isSelected: false, isMatched: false, isMissMatched: false, shape: shape, shading: shading, color: color, number: number))
                    }
                }
            }
        }
        
        deck.shuffle()
    }
    
    func createNewGame() {
        deck.removeAll()
        cardsInGame.removeAll()
        selected.removeAll()
        score = 0
        
        startGame()
        dealMoreCards()
    }
    
    func dealMoreCards() {
        let numberOfCards = max(3, 12 - cardsInGame.count)
        
        for _ in 0..<numberOfCards {
            let card = deck.removeLast()
            cardsInGame.append(card)
        }
    }
    
    private func unmarkAllMismatchedCards() {
        for i in 0..<cardsInGame.count {
            cardsInGame[i].isMissMatched = false
        }
    }
    
    private func unselectAllSelectedCards(selectedIndices: [Int]) {
        for index in selectedIndices {
            cardsInGame[index].isSelected = false
        }
    }
    
    private func markSelectedAsMismatched(selectedIndices: [Int]) {
        for index in selectedIndices {
            cardsInGame[index].isMissMatched = true
            cardsInGame[index].isSelected = false
        }
    }
    
    func chooseCard(card: Card) {
//        hasMatch = false
        unmarkAllMismatchedCards()
        
        if let choosenIndex = self.cardsInGame.firstIndex(matching: card) {
            cardsInGame[choosenIndex].isSelected = !(cardsInGame[choosenIndex].isSelected)
            if cardsInGame[choosenIndex].isSelected {
                selected.append(choosenIndex)
            } else {
                if let idx = selected.firstIndex(of: choosenIndex) {
                    selected.remove(at: idx)
                }
            }
            
            if selected.count == 3 {
                if checkIfSelectedCardsMakeSet() {
                    // Match
                    hasMatch = true
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.9) {
                        self.hasMatch = false
                    }
                    unselectAllSelectedCards(selectedIndices: self.selected)
                    score += 3
                    for index in selected {
                        cardsInGame.remove(at: index)
                    }
                    if deck.count > 0 && cardsInGame.count < 12 {
                        dealMoreCards()
                    }
                } else {
                    // Mismatch
                    score -= 3
                    markSelectedAsMismatched(selectedIndices: self.selected)
                }
                selected.removeAll()
            }
        }
    }
    
    private func checkIfSelectedCardsMakeSet() -> Bool {
        var colors = [Card.ShapeColor: Bool]()
        var shapes = [Card.ShapeType: Bool]()
        var shadings = [Card.Shading: Bool]()
        var numbers = [Card.ShapesNumber: Bool]()
        
        for index in selected {
            let item = cardsInGame[index]
            colors[item.color] = true
            shapes[item.shape] = true
            shadings[item.shading] = true
            numbers[item.number] = true
        }
        
        if colors.count == 2 || shapes.count == 2 || shadings.count == 2 || numbers.count == 2 {
            return false
        }
        
        return true
    }
    
}
