//
//  HomeViewModel.swift
//  Pushka
//
//  Created by Negi on 14/10/25.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var books: [Book] = DeveloperPreview.shared.books
    
    func addBook(_ book: Book) {
        books.append(book)
    }
}
