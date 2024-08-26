//
//  AddBookView.swift
//  SwiftUIBookWorm
//
//  Created by Kunal Kumar R on 23/08/24.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var rating = 0
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of the book", text: $title)
                    TextField("Name of the author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    HStack {
                        Text("Rating")
                        Spacer()
                        RatingView(rating: $rating)
                    }
                    .buttonStyle(.plain)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        //  Insert book into model context
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(title.isEmpty || author.isEmpty || genre.isEmpty || review.isEmpty || rating < 1)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
