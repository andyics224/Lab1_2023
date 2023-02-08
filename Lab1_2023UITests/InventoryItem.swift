//
//  InventoryItem.swift
//  Lab1_2023
//
//  Created by IMD 224 on 2023-01-31.
//

import SwiftUI

// store the image and sesc associated with each item
struct InventoryItem: Identifiable {
    let id = UUID()
    var image: String
    var description: String
    var toggle: Bool
    
    init(image: String, description: String, toggle: Bool) {
        self.image = image
        self.description = description
        self.toggle = toggle
    }
}
