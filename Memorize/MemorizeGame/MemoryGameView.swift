//
//  MemoryGameView.swift
//  Memorize
//
//  Created by Kristina Grebneva on 29.11.2023.
//

import SwiftUI

struct Emoji {
    var name: String
    var collection: [String]
    var symbol: String
    var color: Color
}

struct MemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var colors: [String: Color]? = ["orange": .orange,
                                    "red" : .red,
                                    "green": .green,
                                    "blue": .blue,
                                    "yellow": .yellow,
                                    "purple": .purple]
    
    private let dealAnimation: Animation = .easeInOut(duration: 0.5)
    private let dealInterval: TimeInterval = 0.1
    private let deckWidth: CGFloat = 50
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        NavigationView {
            VStack {
                cards
                VStack {
                    deck
                    Spacer()
                    score
                    Spacer()
                }
                .frame(height: 30)
            }
            .padding()
            .navigationTitle(viewModel.themeName)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    startNewGame
                }
                
            }
        }
        
    }
    
    var startNewGame: some View {
        Button("New Game") {
            dealt.removeAll()
            viewModel.start()
        }
    }
    
    var score: some View {
        Text("Your score is \(viewModel.score)")
            .font(.title2)
            .animation(nil)
    }
    
    var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) {card in
            if isDealt(card) {
                CardView(card)
                    .overlay(FlyingNumbers(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .foregroundColor(colors?[viewModel.themeColor] ?? Color.gray)
    }
    
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var unDealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(unDealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
            .frame(width: deckWidth, height: deckWidth / aspectRatio)
        }
        .foregroundColor(colors?[viewModel.themeColor] ?? Color.gray)
        .onTapGesture {
           deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            _ = withAnimation(dealAnimation.delay(delay)) {
                dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
    
    func choose(_ card: Card) {
        withAnimation{
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    typealias Card = MemoryGame<String>.Card
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        Text(card.content)
            .font(.system(size: 200))
            .minimumScaleFactor(0.01)
            .aspectRatio(1, contentMode: .fit)
            .cardify(isFaceUp: card.isFaceUp)
            .padding(3)
        .opacity(card.isFaceUp || !card.isMatches ? 1 : 0)
    }
}

#Preview {
    MemoryGameView(viewModel: EmojiMemoryGame())
}
