//
//  ContentViewModel.swift
//  SwiftUIBucketList
//
//  Created by Kunal Kumar R on 26/08/24.
//

import Foundation
import MapKit
import CoreLocation


extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        // Initializer
        init() {
            do {
                let data =  try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            }catch {
                locations = []
            }
        }
        
        // Save method
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            }catch {
                print("uanble to save data.")
            }
        }
        
        // Add location method
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        // Update location methods
        func updateLocation(location: Location) {
            guard let selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
    }
}
