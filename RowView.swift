//
//  RowView.swift
//  Lab1_2023
//
//  Created by IMD 224 on 2023-01-31.
//

import SwiftUI

struct RowView: View {
    var inventoryItem: InventoryItem
    var colour: Color
    var bgColor: Color = Color.white
    var body: some View {
        HStack {
            Image(systemName: inventoryItem.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .leading)
                .background(inventoryItem.toggle ? colour : bgColor)
            Text(inventoryItem.description)
                .frame(width: 200, height: 100, alignment: .leading)
        }
        .padding()
    }
}

struct RowView_Previews: PreviewProvider {
    static var inventoryItems = InventoryItems(previewMode: true)
    static var previews: some View {
        RowView(inventoryItem: inventoryItems.entries[0], colour: Color.white)
    }
}
