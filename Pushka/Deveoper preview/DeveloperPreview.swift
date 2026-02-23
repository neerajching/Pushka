//
//  DeveloperPreview.swift
//  Pushka
//
//  Created by Admin on 05/09/25.
//

import Foundation

struct DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let books: [UserBook] = [
            UserBook(
                title: "The Idiot",
                author: "Fyodor Dostoevsky",
                coverURL: URL(string: "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1657539107i/12505.jpg"),
                status: .read
            ),
            UserBook(
                title: "War and Peace",
                author: "Leo Tolstoy",
                coverURL: URL(string: "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1413215930i/656.jpg"),
                status: .currentlyReading
            ),
            UserBook(
                title: "Crime and Punishment",
                author: "Fyodor Dostoevsky",
                coverURL: URL(string: "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1382846449i/7144.jpg"),
                status: .wantToRead
            ),
            // New books
            UserBook(
                title: "Pride and Prejudice",
                author: "Jane Austen",
                coverURL: URL(string: "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1681804503i/129915654.jpg"),
                status: .wantToRead
            ),
            UserBook(
                title: "1984",
                author: "George Orwell",
                coverURL: URL(string: "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1657781256i/61439040.jpg"),
                status: .currentlyReading
            ),
            UserBook(
                title: "The Great Gatsby",
                author: "F. Scott Fitzgerald",
                coverURL: URL(string: "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1650033243i/41733839.jpg"),
                status: .read
            )
        ]
}
