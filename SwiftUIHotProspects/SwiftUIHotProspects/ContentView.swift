//
//  ContentView.swift
//  SwiftUIHotProspects
//
//  Created by Kunal Kumar R on 27/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .yetToContact)
                .tabItem {
                    Label("Yet to contact", systemImage: "questionmark.diamond")
                }
            PersonalInfoView()
                .tabItem {
                    Label("ME", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    ContentView()
}
