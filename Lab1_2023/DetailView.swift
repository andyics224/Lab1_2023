//
//  ContentView.swift
//  Lab1_2023
//
//  Created by IMD 224 on 2023-01-10.
//

import SwiftUI
import Foundation
import Photos

struct DetailView: View {
    @State private var description = ""
    @State private var favourite = false
    @Binding var inventoryItem: InventoryItem
    
    @State var pickerVisible = false
    @State var showCameraAlert = false
    @State var imageSource = UIImagePickerController.SourceType.camera
    
    var colour: Color
    var maxChars: Int
    var bgColor: Color = Color.white
    var body: some View {
        
        VStack {
            Image(systemName: inventoryItem.image)
                .resizable(resizingMode: .stretch)
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .background(inventoryItem.toggle ? colour : bgColor).accessibilityIdentifier("DetailImage")
            Toggle(isOn: $inventoryItem.toggle) {
                
                Text("Favourite")
            }.accessibilityIdentifier("FavouriteToggle")
            TextEditor(text:
                Binding(
                    get: {
                        inventoryItem.description
                    },
                    set: {
                        newValue in
                        if newValue.count <= maxChars {
                            inventoryItem.description = newValue
                        }
                    }
                )
            ).accessibilityIdentifier("DetailTextEditor")
            Text("\(String(inventoryItem.description.count))/\(maxChars)").accessibilityIdentifier("DetailText")
                .navigationBarItems(trailing:
                Button(action: {
                    AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                        if response && UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                            self.showCameraAlert = false
                            self.imageSource = UIImagePickerController.SourceType.camera
                            self.pickerVisible.toggle()
                        } else {
                            self.showCameraAlert
                        }
                    }
                }) {
                    Image(systemName: "camera")
                }
                .alert(isPresented: $showCameraAlert){
                    Alert(title: Text("Error"), message: Text("Camera not avilable"), dismissButton: .default(Text("OK")))
                }
            )
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    @State static var inventoryItems = InventoryItems()
    static var previews: some View {
        DetailView(inventoryItem: $inventoryItems.entries[0], colour: Color.yellow, maxChars: 150)
    }
}
