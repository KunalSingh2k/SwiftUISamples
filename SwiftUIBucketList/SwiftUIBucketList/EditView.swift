//
//  EditView.swift
//  SwiftUIBucketList
//
//  Created by Kunal Kumar R on 26/08/24.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String
    @State private var description: String
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    var location: Location
    var onSave: (Location) -> Void
    
    //MARK: - Initalizer
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby...") {
                    switch loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(":") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismiss()
                }
                .task {
                    await fetchNearbyPlaces()
                }
            }
        }
    }
}

#Preview {
    EditView(location: .example) { _ in }
}


//MARK: - Decoding data
extension EditView {
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad url: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let places = try JSONDecoder().decode(Result.self, from: data)
            pages = places.query.pages.values.sorted()
            loadingState = .loaded
            
        }catch {
            loadingState = .failed
        }
    }
}
