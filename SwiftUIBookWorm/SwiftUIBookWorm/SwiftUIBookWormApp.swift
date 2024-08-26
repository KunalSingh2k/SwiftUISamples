//
//  SwiftUIBookWormApp.swift
//  SwiftUIBookWorm
//
//  Created by Kunal Kumar R on 23/08/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftUIBookWormApp: App {
//    let modelContainer: ModelContainer
//    
//    init() {
//        do {
//            modelContainer = try ModelContainer(for: Book.self)
//        }catch {
//            fatalError("Cannot intialize model container")
//        }
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
