//
//  ContentView.swift
//  SwiftDataSample
//
//  Created by Kunal Kumar R on 23/08/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showNewJoiningUsers = false
    @State private var path = [User]()
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
                UsersView(minimumJoinDate: showNewJoiningUsers ? .now: .distantPast, sortOrder: sortOrder)
            .navigationTitle("Users")
            .toolbar {
                Button(showNewJoiningUsers ? "Show everyone": "Show newJoiners") {
                    showNewJoiningUsers.toggle()
                }
            }
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate),
                            ])
                        
                        Text("Sort by joinDate")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate)
                            ])
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
