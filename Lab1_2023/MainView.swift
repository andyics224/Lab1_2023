//
//  MainView.swift
//  Lab1_2023
//
//  Created by IMD 224 on 2023-01-17.
//

import SwiftUI

struct MainView: View {
    @State private var showSettings = false
    //@State var colour = Color.yellow
    @State var colour = array2color(array: UserDefaults.standard.object(forKey: "BackgroundColour") as? [CGFloat] ?? color2array(colour: Color.yellow))
    //@State var maxChars = 150
    @State var maxChars = UserDefaults.standard.object(forKey: "MaxCharacterCount") as? Int ?? 150
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var inventoryItems: InventoryItems
    
    var body: some View {
        NavigationStack() {
            VStack {
                if showSettings {
                    SettingsView(colour: $colour, maxChars: $maxChars)
                }
                else {
                    List($inventoryItems.entries) {
                        $inventoryItem in
                        NavigationLink(
                            destination: DetailView(inventoryItem: $inventoryItem, colour: colour, maxChars: maxChars)
                        ) {
                            RowView(inventoryItem: inventoryItem, colour: colour)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                inventoryItems.entries.removeAll(where: { $0.id == inventoryItem.id})
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            // Add a title on top of the list
            .navigationBarTitle(Text("Inventory"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    if !showSettings {
                        Button(
                            action: {
                                withAnimation {
                                    let item = InventoryItem(image: "ladybug", description: "Ladybug", toggle: false)
                                    inventoryItems.entries.insert(item, at: 0)
                                }
                            }
                        ) {
                            Image(systemName: "plus")
                        }
                        .accessibilityIdentifier("PlusButton")
                    }
                }
                ToolbarItem(placement: .bottomBar){
                    Button(
                        action: {
                            showSettings.toggle()
                            //UserDefaults.standard.set(maxChars, forKey: "MaxCharacterCount")
                        },
                        label: {
                            Image(systemName: showSettings ? "house" : "gear")
                        }
                    ).accessibilityIdentifier("NavigationButton")
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPad (10th generation)", "iPhone 14 Pro"], id: \.self) { deviceName in
            MainView()
                .previewDevice(PreviewDevice(rawValue: deviceName)).environmentObject(InventoryItems(previewMode: true))
            
        }
    }
}
