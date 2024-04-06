//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Kristina Grebneva on 28.02.2024.
//

import SwiftUI

//View for editing theme style
struct ThemeEditor: View {
    @Binding var theme: EmojiTheme
    
    @State var newName: String = ""
    
    @State private var newEmoji: String = ""
    var animation: Animation = .easeInOut.speed(0.5)
    
    var body: some View {
        List {
            colorChooser
            
            Section {
                emoji
                emojiAdder
                stepper
            } header: {
               nameOfSection
            }
        }
    }
    
    var colorChooser: some View {
        Section {
            HStack {
                TextField("name", text: $theme.name)
                    .font(.title2)
                    .foregroundColor(theme.color)
                    .layoutPriority(1)
                ColorPicker("", selection: $theme.color)
                    
            }
        }
    }
    
    var emoji: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 20))]) {
            ForEach(theme.currentKit, id: \.self) {emoji in
                Text(emoji)
                    .onTapGesture {
                        withAnimation(animation) {
                            theme.deleteEmoji(customEmoji: emoji)
                        }

                    }
            }
        }
    }
    
    var emojiAdder: some View {
        HStack {
            TextField("Add emoji here", text: $newEmoji)
            
            Button {
                withAnimation(animation) {
                    theme.addCustomEmoji(newEmoji)
                }
            } label: {
                Image(systemName: "checkmark.square")
                    .foregroundColor(.green)
            }
            .buttonStyle(.bordered)
            .font(.title2)
            .foregroundColor(.black)
        }
    }
    
    @ViewBuilder
    var stepper: some View {
        if !theme.kit.isEmpty {
            Stepper() {
                Text("Number of emojis: \(theme.number)")
            } onIncrement: {
                withAnimation(animation) {
                    theme.addEmoji()
                }
            } onDecrement: {
                withAnimation(animation) {
                    theme.deleteEmoji(customEmoji: nil)
                }
            }
        }
    }
    
    var nameOfSection: some View {
        HStack {
            Text("EMOJIS")
            Spacer()
            Text("Tap to delete")
                .textCase(nil)
        }
    }
}

struct conView: View {
    @State var theme: EmojiTheme
    
    var body: some View {
        ThemeEditor(theme: $theme)
    }
}


#Preview {
    conView(theme: EmojiTheme.buildings[0])
}
