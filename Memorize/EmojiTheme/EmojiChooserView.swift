//
//  EmojiChooserView.swift
//  Memorize
//
//  Created by Kristina Grebneva on 23.02.2024.
//

import SwiftUI

//ThemeView
struct EmojiChooserView: View {
    @ObservedObject var themes: EmojiDocument
    
    @State var selectedIndex: Int = 0
    @State var showEditView: Bool = false
 
    var body: some View {
        NavigationStack {
          listOfThemes
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add new theme", systemImage: "plus") {
                        addNewTheme()
                    }
                }
            }
            .navigationTitle("Themes")
        }
    }
    
    var listOfThemes: some View {
        List {
            ForEach(themes.document.array) {theme in
                NavigationLink(value: theme) {
                    showRow(of: theme)
                }
            }
            .onDelete { indexSet in
                selectedIndex = 0
                withAnimation{
                    themes.document.array.remove(atOffsets: indexSet)
                }
                
            }
            .onMove { indexSet, newOffset in
                themes.document.array.move(fromOffsets: indexSet, toOffset: newOffset)
            }
            
        }
        .navigationDestination(isPresented: $showEditView) {
            ThemeEditor(theme: $themes.document.array[selectedIndex])
        }
        .navigationDestination(for: EmojiTheme.self) {theme in
           let model = EmojiMemoryGame(theme: theme)
           MemoryGameView(viewModel: model)
        }
    }
    
    func addNewTheme() {
        themes.addTheme()
        selectedIndex = themes.document.array.count - 1
        showEditView.toggle()
    }
    
    func showCollection(of theme: EmojiTheme) -> String {
        if theme._kit.isEmpty {
            theme.currentKit.joined()
        } else {
            theme._kit
        }
        
    }
    
    func showRow(of theme: EmojiTheme) -> some View {
        VStack {
            HStack {
                Text(theme.name)
                    .font(.title)
                Spacer()
            }
            .foregroundColor(theme.color)
            
            HStack {
                Text("\(theme.number) pairs from \(showCollection(of: theme))")
                    .lineLimit(1)
                Spacer()
            }
        }
        .swipeActions(edge: .leading) {
            Button("Edit") {
                if let index = themes.findIndex(of: theme) {
                    selectedIndex = index
                    showEditView.toggle()
                }
            }
            .tint(.blue)
        }
    }
}


//#Preview {
//    EmojiChooserView()
//}
