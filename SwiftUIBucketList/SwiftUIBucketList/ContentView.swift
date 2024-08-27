//
//  ContentView.swift
//  SwiftUIBucketList
//
//  Created by Kunal Kumar R on 26/08/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let initialPositsion = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()

    var body: some View {
        MapReader { proxy in
            Map(initialPosition: initialPositsion) {
                ForEach(viewModel.locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 25, height: 25)
                            .background(.white)
                            .clipShape(.circle)
                            .onLongPressGesture {
                                viewModel.selectedPlace = location
                            }
                    }
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) {
                    viewModel.updateLocation(location: $0)
                }
            }
            .onTapGesture { position in
                if let coordinate  = proxy.convert(position, from: .local) {
                    viewModel.addLocation(at: coordinate)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
