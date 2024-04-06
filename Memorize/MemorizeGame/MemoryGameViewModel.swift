//
//  MemoryGameViewModel.swift
//  Memorize
//
//  Created by Kristina Grebneva on 07.12.2023.
//

import Foundation

struct Themes {
    var all: [Theme] = []
    var currentTheme: Theme
    
    func getRandomTheme() -> Theme {
        all.randomElement() ?? all[0]
    }
    
    init() {
        all.append(Theme(name: "Animals", emoji: ["🐶", "🐯", "🐨", "🐰", "🦆", "🐌", "🐢", "🐮", "🐝"], color: "orange"))
        all.append(Theme(name: "Vehicle", emoji: ["🚗", "🚅", "✈️", "🚀", "🛥️", "🛵", "🛴", "🚁", "⛵️"], color: "red"))
        all.append(Theme(name: "Food", emoji: ["🍏", "🍌", "🍔", "🥓", "🍣", "🥩","🍳", "🥞", "🥑"], color: "yellow"))
        all.append(Theme(name: "Body", emoji: ["🦷", "👅", "👁️", "👂🏿", "🧠", "🫀", "👃🏽", "🦶🏼"], color: "blue"))
        all.append(Theme(name: "Jobs", emoji: ["💂‍♀️", "👮‍♀️", "🕵️‍♀️", "👩‍🏫", "🧑‍💻", "👩‍⚖️", "🥷", "👨‍🔬"], color: "green"))
        all.append(Theme(name: "Clothes", emoji: ["🧥", "🩲", "👙", "👘", "👗", "👖", "👠", "🧤"], color: "purple"))
        
        currentTheme = all.randomElement() ?? all[0]
    }
    
    struct Theme {
        var name: String
        var emoji: [String]
        var color: String
    }
}

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    static var theme = Themes().getRandomTheme()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let maxNumberOfPairsOfCards = theme.emoji.count
        
        return MemoryGame(numberOfPairsOfCards: Int.random(in: 2...maxNumberOfPairsOfCards)) { pairIndex in
            if theme.emoji.indices.contains(pairIndex) {
                return theme.emoji[pairIndex]
            } else {
                return "⁉️"
            }
            }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var themeName: String {
        return EmojiMemoryGame.theme.name
    }
    
    var themeColor: String {
        return EmojiMemoryGame.theme.color
    }
    
    // MARK: - Intents
    
    func start() {
        EmojiMemoryGame.theme = Themes().getRandomTheme()
        model = EmojiMemoryGame.createMemoryGame()
        model.shuffle()
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    init() {
        let maxNumberOfPairsOfCards = EmojiMemoryGame.theme.emoji.count
        
        model = MemoryGame(numberOfPairsOfCards: Int.random(in: 2...maxNumberOfPairsOfCards)) { pairIndex in
            if EmojiMemoryGame.theme.emoji.indices.contains(pairIndex) {
                return EmojiMemoryGame.theme.emoji[pairIndex]
            } else {
                return "⁉️"
            }
        }
        
        model.shuffle()
    }
}
