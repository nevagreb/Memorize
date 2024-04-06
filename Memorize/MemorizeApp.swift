//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Kristina Grebneva on 29.11.2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    @StateObject var themes = EmojiDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiChooserView(themes: themes)
        }
    }
}
