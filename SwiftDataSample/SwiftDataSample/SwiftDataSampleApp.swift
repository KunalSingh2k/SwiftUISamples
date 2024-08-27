//
//  SwiftDataSampleApp.swift
//  SwiftDataSample
//
//  Created by Kunal Kumar R on 23/08/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
