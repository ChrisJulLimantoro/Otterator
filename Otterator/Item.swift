//
//  Item.swift
//  Otterator
//
//  Created by Christopher Julius on 12/07/24.
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
