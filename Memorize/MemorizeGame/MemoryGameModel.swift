//
//  MemoryGameModel.swift
//  Memorize
//
//  Created by Kristina Grebneva on 07.12.2023.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    //access control
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        //add number of cards x 2
        
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    var indexOfOneAndeOnlyFacedUpCard: Int? {
        get { cards.indices.filter {index in cards[index].isFaceUp}.only }
        set { cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)} }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatches {
                if let potentialMatchIndex = indexOfOneAndeOnlyFacedUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatches = true
                        cards[potentialMatchIndex].isMatches = true
                        score += 2
                    }
                } else {
                    indexOfOneAndeOnlyFacedUpCard = chosenIndex
                }
                if cards[chosenIndex].isSeen && !cards[chosenIndex].isMatches {
                    score -= 1
                }
                cards[chosenIndex].isSeen = true
                cards[chosenIndex].isFaceUp = true
            }
        }
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = false
        var isMatches: Bool = false
        var isSeen: Bool = false
        let content: CardContent
        
        let id: String
        
        var debugDescription: String {
            return "\(id): \(content) \(isSeen ? "Yes" : "No")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
    
}
