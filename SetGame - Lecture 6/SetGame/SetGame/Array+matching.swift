//
//  Array+matching.swift
//  SetGame
//
//  Created by user on 03.08.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for i in 0..<count {
            if self[i].id == matching.id {
                return i
            }
        }
        return nil
    }
}
