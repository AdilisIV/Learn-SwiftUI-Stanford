//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by user on 07.08.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    
    @ObservedObject var document: EmojiArtDocument
    
    private let defaultEmojiSize: CGFloat = 40
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(EmojiArtDocument.palette.map{ String($0) }, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.defaultEmojiSize))
                            .onDrag { return NSItemProvider(object: emoji as NSString) }
                    }
                }
            }
            .padding(.horizontal)
            GeometryReader { geometry in
                ZStack {
                    Color.white
                        .overlay(
                            Group {
                                if self.document.backgroundImage != nil {
                                    Image(uiImage: self.document.backgroundImage!)
                                }
                            }
                        )
                        .edgesIgnoringSafeArea([.horizontal, .bottom])
                        .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                            // SwiftUI bug (as of 13.4)? the location is supposed to be in our coordinate system
                            // however, the y coordinate appears to be in the global coordinate system
                            var location = CGPoint(x: location.x, y: geometry.convert(location, from: .global).y)
                            location = CGPoint(x: location.x - geometry.size.width / 2, y: location.y - geometry.size.height / 2) // convert it (0,0) in the upper left to (0,0) in the middle
                            
                            return drop(providers: providers, at: location)
                        }
                    ForEach(self.document.emojis) { emoji in
                        Text(emoji.text)
                            .font(self.font(for: emoji))
                            .position(self.location(for: emoji, in: geometry.size))
                    }
                }
            }
        }
    }
    
    private func font(for emoji: EmojiArt.Emoji) -> Font {
        Font.system(size: emoji.fontSize)
    }
    
    private func location(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        // convert it again to that (0,0) in middle instead (0,0) in the upper left here
        CGPoint(x: emoji.location.x + size.width / 2, y: emoji.location.y + size.height / 2)
    }
    
    private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool {
        var found = providers.loadFirstObject(ofType: URL.self, using: { url in
            self.document.setBackgroundURL(url)
        })
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                self.document.addEmoji(string, at: location, size: self.defaultEmojiSize)
            }
        }
        return found
    }
}

//extension String: Identifiable {
//    public var id: String { // public is non private in a library; people can see it mathod outside the library
//        return self
//    }
//}
