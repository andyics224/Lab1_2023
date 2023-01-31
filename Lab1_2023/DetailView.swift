//
//  ContentView.swift
//  Lab1_2023
//
//  Created by IMD 224 on 2023-01-10.
//

import SwiftUI
import Foundation

struct DetailView: View {
    @State private var description = ""
    @State private var favourite = false
    var colour: Color
    var maxChars: Int
    var bgColor: Color = Color.white
    var body: some View {
        
        VStack {
            Image(systemName: "bolt.car")
                .resizable(resizingMode: .stretch)
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .background(favourite ? colour : bgColor).accessibilityIdentifier("DetailImage")
            Toggle(isOn: $favourite) {
                Text("Favourite")
            }.accessibilityIdentifier("FavouriteToggle")
            TextEditor(text:
                Binding(
                    get: {
                        description
                    },
                    set: {
                        newValue in
                        if newValue.count <= maxChars {
                            description = newValue
                        }
                    }
                )
            ).accessibilityIdentifier("DetailTextEditor")
            Text("\(String(description.count))/\(maxChars)").accessibilityIdentifier("DetailText")
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(colour: Color.yellow, maxChars: 150)
    }
}
