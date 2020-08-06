//
//  View+OnlyStackNavigation.swift
//  SetGame
//
//  Created by user on 06.08.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import SwiftUI

extension View {
    
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
    
}
