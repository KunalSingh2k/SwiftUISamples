//
//  CustomNavBar.swift
//  SwiftUINavigationSample
//
//  Created by Kunal Kumar R on 22/08/24.
//

import SwiftUI

struct CustomNavBar: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle("Title goes here")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
            //.toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    CustomNavBar()
}
