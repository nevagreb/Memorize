//
//  EmojiDocument.swift
//  Memorize
//
//  Created by Kristina Grebneva on 23.02.2024.
//

import Foundation
import SwiftUI

//ViewModel for themes
class EmojiDocument: ObservableObject {
    @Published var document = EmojiThemes() {
        didSet {
            autosave()
        }
    }
    
    private let autosaveURL = URL.documentsDirectory.appendingPathComponent("Autosave.theme")
    
    private func autosave() {
        save(to: autosaveURL)
    }
    
    private func save(to url: URL) {
        do {
            let data = try document.json()
            try data.write(to: url)
        } catch let error {
            print("Error while saving \(error.localizedDescription)")
        }
    }
    
    
    init() {
        if let data = try? Data(contentsOf: autosaveURL),
           let autosavedThemes = try? EmojiThemes.load(from: data) {
                document = autosavedThemes
        } else {
            document.array.append(EmojiTheme.buildings[0])
            document.array.append(EmojiTheme.buildings[1])
            document.array.append(EmojiTheme.buildings[2])
        }
    }
    
    // MARK: - Intent(s)

    func findIndex(of theme: EmojiTheme) -> Int? {
        document.array.firstIndex(where: {$0 == theme})
    }
    
    func delete(theme: EmojiTheme) {
        let index = findIndex(of: theme)!
        document.array.remove(at: index)
    }
    
    func addTheme() {
        document.array.append(EmojiTheme())
    }
}

extension EmojiTheme {
    var color: Color {
        get {
            Color(red: _color.r, green: _color.g, blue: _color.b, opacity: _color.a)
        }
        set {
            if let newColor = UIColor(newValue).cgColor.components {
                _color = EmojiColor(r: newColor[0], g: newColor[1], b: newColor[2], a: newColor[3])
            }
        }
    }
}


