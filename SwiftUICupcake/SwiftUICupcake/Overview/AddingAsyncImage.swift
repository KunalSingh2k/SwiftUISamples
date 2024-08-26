//
//  AddingAsyncImage.swift
//  SwiftUICupcake
//
//  Created by Kunal Kumar R on 22/08/24.
//

import SwiftUI

struct AddingAsyncImage: View {
    @State private var results = [Result]()
    
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            }else if phase.error != nil {
                Text("There was a error loading your image")
            }else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
        
            
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("invalid url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        }catch {
            print(error.localizedDescription)
        }
    }
}


#Preview {
    AddingAsyncImage()
}
