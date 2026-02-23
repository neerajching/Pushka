//
//  HomeViewModel.swift
//  Pushka
//
//  Created by Negi on 14/10/25.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var books: [UserBook] = DeveloperPreview.shared.books
    
    func addBook(_ book: UserBook) {
        books.append(book)
    }
}
