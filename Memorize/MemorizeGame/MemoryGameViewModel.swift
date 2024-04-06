//
//  MemoryGameViewModel.swift
//  Memorize
//
//  Created by Kristina Grebneva on 07.12.2023.
//

//ViewModel for MemoryGame
import Foundation
import SwiftUI

struct Themes {
    var currentTheme: Theme
    
    init(theme: EmojiTheme) {
        currentTheme = Theme(name: theme.name, emoji: theme.currentKit, color: theme.color)
    }
    
    struct Theme {
        var name: String
        var emoji: [String]
        var color: Color
    }
}

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    var theme: Themes.Theme
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var themeName: String {
        return theme.name
    }
    
    var themeColor: Color {
        return theme.color
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    init(theme: EmojiTheme) {
        self.theme = Themes(theme: theme).currentTheme
        
        model = MemoryGame(numberOfPairsOfCards: theme.number) { pairIndex in
            if theme.currentKit.indices.contains(pairIndex) {
                return theme.currentKit[pairIndex]
            } else {
                return "⁉️"
            }
        }
        
        model.shuffle()
    }
}


