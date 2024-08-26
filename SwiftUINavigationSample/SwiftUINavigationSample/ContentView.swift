//
//  ContentView.swift
//  SwiftUINavigationSample
//
//  Created by Kunal Kumar R on 22/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var title = "SwiftUI"
    @State private var pathStore = PathStore()
    
    var body: some View {
//        NavigationStack {
//            List(0..<100) { i in
//                NavigationLink("Select \(i)",value: i)
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
//            .navigationTitle($title)
//            .navigationBarTitleDisplayMode(.inline)
//        }
        
        NavigationStack(path: $pathStore.path) {
            DetailView(number: 0)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i)
                }
        }
    }
}

struct DetailView: View {
    var number: Int
    
    var body: some View {
        NavigationLink("Random number", value: Int.random(in: 1...10))
            .navigationTitle("Number \(number)")
    }
}


#Preview {
    ContentView()
}
