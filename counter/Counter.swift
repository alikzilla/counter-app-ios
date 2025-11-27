//
//  Counter.swift
//  counter
//
//  Created by Алихан on 29.11.2025.
//

import Foundation
import SwiftData

@Model
final class Counter {
    var count: Int
    
    init(count: Int = 0) {
        self.count = count
    }
}
