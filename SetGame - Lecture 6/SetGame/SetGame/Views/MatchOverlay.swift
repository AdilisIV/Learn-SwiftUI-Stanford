//
//  MatchOverlay.swift
//  SetGame
//
//  Created by user on 06.08.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import SwiftUI

struct MatchOverlay: View {
    var body: some View {
        ZStack {
            Color(.white).opacity(0.72)
            Image("match_badge")
                .rotationEffect(.degrees(-13))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MatchOverlay_Previews: PreviewProvider {
    static var previews: some View {
        MatchOverlay()
    }
}
