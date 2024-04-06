//
//  Emoji.swift
//  Memorize
//
//  Created by Kristina Grebneva on 23.02.2024.
//

import Foundation

//Model for themes
let startEmojiNumber = 8

struct EmojiThemes: Hashable, Codable {
    var array: [EmojiTheme]
    
    init(json: Data) throws {
        self = try JSONDecoder().decode(EmojiThemes.self, from: json)
    }
    
    init() {
        array = []
    }
    
    func json() throws -> Data {
        let encoded = try JSONEncoder().encode(self)
        return encoded
    }
    
    static func load(from json: Data) throws -> EmojiThemes {
        return try JSONDecoder().decode(EmojiThemes.self, from: json)
    }
}

struct EmojiTheme: Identifiable, Equatable, Hashable, Codable {
    var name: String
    var _kit: String
    var number: Int
    
    var _color: EmojiColor
    var id = UUID()
    
    var currentIndex: Int = 0
    var kit: [String] = []
    var currentKit: [String] = []
    var newEmoji: [String] = []
    
    struct EmojiColor: Hashable, Codable {
        var r: Double
        var g: Double
        var b: Double
        var a: Double
        
        static var red = EmojiColor(r: 1, g: 0.23, b: 0.18, a: 1)
        static var green = EmojiColor(r: 0.20, g: 0.78, b: 0.34, a: 1)
        static var blue = EmojiColor(r: 0, g: 0.47, b: 1, a: 1)
        static var gray = EmojiColor(r: 0.55, g: 0.55, b: 0.55, a: 1)
    }
   
    static var buildings: [EmojiTheme] { [
        EmojiTheme(name: "Animals&Nature", emoji:
                    "🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐽🐸🐵🙈🙉🙊🐒🐔🐧🐦🐦‍⬛🐤🐣🐥🦆🦅🦉🦇🐺🐗🐴🦄🐝🪱🐛🦋🐌🐞🐜🪰🪲🪳🦟🦗🕷🕸🦂🐢🐍🦎🦖🦕🐙🦑🦐🦞🦀🪼🪸🐡🐠🐟🐬🐳🐋🦈🐊🐅🐆🦓🫏🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🐂🐄🐎🐖🐏🐑🦙🐐🦌🫎🐕🐩🦮🐕‍🦺🐈🐈‍⬛🪽🪶🐓🦃🦤🦚🦜🦢🪿🦩🕊🐇🦝🦨🦡🦫🦦🦥🐁🐀🐿🦔🐾🐉🐲🌵🎄🌲🌳🌴🪹🪺🪵🌱🌿☘️🍀🎍🪴🎋🍃🍂🍁🍄🐚🪨🌾💐🌷🪷🌹🥀🌺🌸🪻🌼🌻🌞🌝🌛🌜🌚🌕🌖🌗🌘🌑🌒🌓🌔🌙🌎🌍🌏🪐💫⭐️🌟✨⚡️☄️💥🔥🌪🌈☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️☃️⛄️🌬💨💧💦🫧☔️☂️🌊", color: EmojiColor.red),
        EmojiTheme(name: "Food", emoji:
                    "🍏🍎🍐🍊🍋🍌🍉🍇🍓🫐🍈🍒🍑🥭🍍🥥🥝🍅🍆🥑🥦🫛🥬🥒🌶🫑🌽🥕🫒🧄🧅🫚🥔🍠🫘🥐🥯🍞🥖🥨🧀🥚🍳🧈🥞🧇🥓🥩🍗🍖🦴🌭🍔🍟🍕🫓🥪🥙🧆🌮🌯🫔🥗🥘🫕🥫🍝🍜🍲🍛🍣🍱🥟🦪🍤🍙🍚🍘🍥🥠🥮🍢🍡🍧🍨🍦🥧🧁🍰🎂🍮🍭🍬🍫🍿🍩🍪🌰🥜🍯🥛🍼🫖☕️🍵🧃🥤🧋🫙🍶🍺🍻🥂🍷🫗🥃🍸🍹🧉🍾🧊🥄🍴🍽🥣🥡🥢🧂", color: EmojiColor.green),
        EmojiTheme(name: "Travel&Places", emoji:
                    "🚗🚕🚙🚌🚎🏎🚓🚑🚒🚐🛻🚚🚛🚜🦯🦽🦼🛴🚲🛵🏍🛺🚨🚔🚍🚘🚖🛞🚡🚠🚟🚃🚋🚞🚝🚄🚅🚈🚂🚆🚇🚊🚉✈️🛫🛬🛩💺🛰🚀🛸🚁🛶⛵️🚤🛥🛳⛴🚢⚓️🛟🪝⛽️🚧🚦🚥🚏🗺🗿🗽🗼🏰🏯🏟🎡🎢🛝🎠⛲️⛱🏖🏝🏜🌋⛰🏔🗻🏕⛺️🛖🏠🏡🏘🏚🏗🏭🏢🏬🏣🏤🏥🏦🏨🏪🏫🏩💒🏛⛪️🕌🕍🛕🕋⛩🛤🛣🗾🎑🏞🌅🌄🌠🎇🎆🌇🌆🏙🌃🌌🌉🌁", color: EmojiColor.blue)
    ]
    }
    
    init(name: String, emoji _kit: String, number: Int = startEmojiNumber, color : EmojiColor, id: UUID = UUID()) {
        self.name = name
        self._kit = _kit
        self.number = number
        self._color = color
        self.id = id
        
        self.kit = _kit.uniqued.map(String.init)
        currentIndex = number
        currentKit = Array(kit.prefix(currentIndex))
    }
    
    init() {
        self.name = ""
        self._kit = ""
        self.number = 0
        self._color = EmojiColor.gray
        self.id = UUID()
        currentIndex = number
        currentKit = []
    }
    
    
    static func ==(lhs: EmojiTheme, rhs: EmojiTheme) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
            
    }
    
    //MARK: - intent(s)
    
    mutating func addEmoji() {
        currentIndex = 0
        while currentIndex < kit.count && currentKit.contains(kit[currentIndex])  {
            currentIndex += 1
        }
        if currentIndex < kit.count {
            currentKit.append(kit[currentIndex])
            number += 1
        }
    }
    
    mutating func addCustomEmoji(_ newEmoji: String) {
        let array = newEmoji.uniqued.map(String.init)
        array.forEach { element in
            if !currentKit.contains(element) {
                currentKit.append(element)
                number += 1
            }
            
        }
        //kit = currentKit
    }
    
    mutating func deleteEmoji(customEmoji: String?) {
        if let emoji = customEmoji {
            if let indexOfEmoji = currentKit.firstIndex(of: emoji) {
                currentKit.remove(at: indexOfEmoji)
                print(currentKit)
                number -= 1
            }
        } else {
            let indexOfLastEmoji = number - 1
            let range = 0 ..< currentKit.count
            if range ~= indexOfLastEmoji {
                currentKit.remove(at: indexOfLastEmoji)
                number -= 1
            }
        }
    }
    
}

extension String {
    var uniqued: String {
        reduce(into: "") { sofar, element in
            if !sofar.contains(element) {
                sofar.append(element)
            }
        }
    }
}
