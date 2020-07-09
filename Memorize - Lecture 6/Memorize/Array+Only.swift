//
//  Array+Only.swift
//  Memorize
//
//  Created by user on 06.07.2020.
//  Copyright © 2020 Ski, LLC. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
