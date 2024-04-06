//
//  Cardify.swift
//  Memorize
//
//  Created by Kristina Grebneva on 18.01.2024.
//

import SwiftUI

//ViewModifier, using to make cards
struct Cardify: ViewModifier, Animatable {
    var isFaceUp: Bool {
        rotation < 90
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0.001 : 180
    }
    
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            base.strokeBorder(lineWidth: 2)
                .background(.white)
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            .degrees(rotation), axis: (0, 1, 0)
        )
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
