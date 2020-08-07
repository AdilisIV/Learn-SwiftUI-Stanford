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
    
    var body: some View {
        HStack {
            ForEach(EmojiArtDocument.palette.map{ String($0) }) { emoji in
                Text(emoji)
            }
        }
    }
}

extension String: Identifiable {
    public var id: String {
        return self
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiArtDocumentView()
//    }
//}
