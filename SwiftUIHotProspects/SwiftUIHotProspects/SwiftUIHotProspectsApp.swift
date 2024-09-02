//
//  SwiftUIHotProspectsApp.swift
//  SwiftUIHotProspects
//
//  Created by Kunal Kumar R on 27/08/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftUIHotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
