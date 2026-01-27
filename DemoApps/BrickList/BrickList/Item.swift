//
//  Item.swift
//  BrickList
//
//  Created by Stephan Zehrer on 27.01.26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
