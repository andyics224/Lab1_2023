//
//  SettingsView.swift
//  Lab1_2023
//
//  Created by IMD 224 on 2023-01-17.
//

import SwiftUI

struct SettingsView: View {
    //@State private var colour = Color.yellow
    @Binding var colour: Color
    @Binding var maxChars: Int
    let step = 10
    let range = 10...300
    var body: some View {
        VStack {
            ColorPicker("Background", selection: $colour).padding()
            Stepper(value: $maxChars, in: range, step: step) {
                Text("Max Character Count: \(maxChars)")
            }.padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var colour = Color.yellow
    @State static var maxChars = 150
    static var previews: some View {
        SettingsView(colour: $colour, maxChars: $maxChars)
    }
}

