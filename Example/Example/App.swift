//
//  ExampleApp.swift
//  Example
//
//  Created by Tomoya Hirano on 2021/10/08.
//

import SwiftUI
import ImageColors

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State var colors: [UIColor] = []
    let image = UIImage(named: "hot-air-balloon-g1ccd66ed1_640.jpg")!
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 200)
                .cornerRadius(6)
            
            Image(systemName: "arrow.down")
            
            LazyHGrid(rows: [
                GridItem(.fixed(44)),
                GridItem(.fixed(44)),
                GridItem(.fixed(44))
            ]) {
                ForEach(colors, id: \.self) { color in
                    Rectangle()
                        .frame(width: 44, height: 44)
                        .foregroundColor(Color(color))
                }
            }
        }.onAppear {
            self.colors = image.colors(maxCount: 12, scale: 0.1)
        }
    }
}




