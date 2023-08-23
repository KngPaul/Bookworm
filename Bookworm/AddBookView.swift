//
//  AddBookView.swift
//  Bookworm
//
//  Created by Paul Onawola on 19/08/2023.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var review = ""
    @State private var rating = 3
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        save()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func save() {
        let newBook = Book(context: moc)
        
        newBook.id = UUID()
        newBook.title = title
        newBook.author = author
        newBook.genre = genre
        newBook.review = review
        newBook.rating = Int16(rating)
        
        try? moc.save()
        dismiss()
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
