//
//  InventoryItems.swift
//  Lab1_2023
//
//  Created by IMD 224 on 2023-01-31.
//

import SwiftUI

class InventoryItems: ObservableObject {
    @Published var entries: [InventoryItem]
    
    init() {
        entries = [InventoryItem]()
        entries.append(InventoryItem(image: "hare", description: "Hare", toggle: false))
        entries.append(InventoryItem(image: "tortoise", description: "Tortoise", toggle: false))
    }
}
