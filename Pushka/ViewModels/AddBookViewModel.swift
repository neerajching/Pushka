//
//  AddBookViewModel.swift
//  Pushka
//
//  Created by Negi on 13/10/25.
//

import Foundation

@MainActor
class AddBookViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var books: [UserBook] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let apiService = BookAPIService()
    
    func searchBooks() async {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedBooks = try await apiService.searchBooks(query: searchText)
            books = fetchedBooks
        } catch {
            errorMessage = "Failed to load books. Please try again."
            print(" API Error:", error)
        }
        
        isLoading = false
    }
}
