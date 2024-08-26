//
//  CustomPath.swift
//  SwiftUINavigationSample
//
//  Created by Kunal Kumar R on 22/08/24.
//

import SwiftUI

@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decodedPath = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decodedPath)
                return
            }
        }
       path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        }catch {
            print("Failed to save navigation data")
        }
    }
}


