//
//  DeveloperPreview.swift
//  Pushka
//
//  Created by Admin on 05/09/25.
//

import Foundation

struct DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let books : [Book] = [
        Book(title: "The Idiot", author: "Fyodor Dostoevsky",
                coverURL: URL(string: "https://covers.openlibrary.org/b/id/8231991-L.jpg")),
        Book(title: "War and Peace", author: "Leo Tolstoy",
                coverURL: URL(string: "https://covers.openlibrary.org/b/id/7222246-L.jpg")),
        Book(title: "The Idiot", author: "Fyodor Dostoevsky",
                coverURL: URL(string: "https://covers.openlibrary.org/b/id/8231991-L.jpg")),
        Book(title: "War and Peace", author: "Leo Tolstoy",
                coverURL: URL(string: "https://covers.openlibrary.org/b/id/7222246-L.jpg")),
        
    ]
}
