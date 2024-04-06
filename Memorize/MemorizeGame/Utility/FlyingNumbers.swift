//
//  FlyingNumbers.swift
//  Memorize
//
//  Created by Kristina Grebneva on 19.01.2024.
//

import SwiftUI

//Animation to draw attention to the match or mismatch
struct FlyingNumbers: View {
    let number: Int
    @State private var offset: CGFloat = 0
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundStyle(number < 0 ? .red : .green)
                .shadow(color: .black, radius: 1.5, x: 1, y: 1)
                .offset(x: 0, y: offset)
                .opacity(offset != 0 ? 0 : 1)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)) {
                        offset = number < 0 ? 200 : -200
                    }
                }
                .onDisappear {
                    offset = 0
                }
        }
            
    }
}

#Preview {
    FlyingNumbers(number: 1)
}
