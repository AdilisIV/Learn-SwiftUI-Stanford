//
//  ActionButtonStyle.swift
//  SetGame
//
//  Created by user on 06.08.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import SwiftUI

struct ActionButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ActionButton(configuration: configuration)
    }
    
    struct ActionButton: View {
        let configuration: ButtonStyleConfiguration
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            configuration.label.foregroundColor(isEnabled ? Color.accentColor : Color.secondary)
        }
    }
}
