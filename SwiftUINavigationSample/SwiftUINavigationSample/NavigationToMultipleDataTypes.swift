//
//  NavigationToMultipleDataTypes.swift
//  SwiftUINavigationSample
//
//  Created by Kunal Kumar R on 22/08/24.
//

import SwiftUI

struct NavigationToMultipleDataTypes: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(0..<5) { i in
                    NavigationLink("select number: \(i)", value: i)
                }
                
                ForEach(0..<5) { i in
                    NavigationLink("select string: \(i)", value: String(i))
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected the String \(selection)")
            }
            .toolbar {
                Button("push 556") { path.append(556) }
                Button("push Hello") { path.append("Hello") }
            }
        }
    }
}

#Preview {
    NavigationToMultipleDataTypes()
}
