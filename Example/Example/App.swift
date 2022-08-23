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
        ScrollView {
            Image(uiImage: image)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 200)
                .cornerRadius(6)
            
            Image(systemName: "arrow.down")
            
            LazyVGrid(columns: [
                GridItem(.fixed(44)),
                GridItem(.fixed(44)),
                GridItem(.fixed(44)),
                GridItem(.fixed(44)),
                GridItem(.fixed(44)),
            ]) {
                ForEach(colors, id: \.self) { color in
                    Button {
                        print(color)
                    } label: {
                        Rectangle()
                            .frame(width: 44, height: 44)
                            .background(.gray)
                            .foregroundColor(Color(color))
                    }
                }
            }
        }.onAppear {
            self.colors = image
                .colors(maxCount: 16, scale: 1, minimumSaturation: 0, threshold: 0)
                .sortedByHSB()
        }
    }
}

