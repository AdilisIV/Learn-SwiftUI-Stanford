//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Mac on 09.11.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import Foundation

struct EmojiArt {
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable {
        let id: Int
        let text: String
        var x: Int // offset from center
        var y: Int // offset from center
        var size: Int
        
        fileprivate init(id: Int, text: String, x: Int, y: Int, size: Int) {
            self.id = id
            self.text = text
            self.x = x
            self.y = y
            self.size = size
        }
    }
    
    private var uniqueEmojiId: Int = 0
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        emojis.append(Emoji(id: uniqueEmojiId, text: text, x: x, y: y, size: size))
        uniqueEmojiId += 1
    }
}
