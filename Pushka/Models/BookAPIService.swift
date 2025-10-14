//
//  BookAPIService.swift
//  Pushka
//
//  Created by Negi on 13/10/25.
//

import Foundation

enum BookAPIError: Error, LocalizedError {
    case invalidQuery
    case invalidURL
    case decodingError
    case requestFailed(statusCode: Int)
    case noData

    var errorDescription: String? {
        switch self {
        case .invalidQuery: return "Invalid search query."
        case .invalidURL: return "Could not form a valid URL."
        case .decodingError: return "Failed to decode response."
        case .requestFailed(let code): return "Request failed with code \(code)."
        case .noData: return "No data received from the server."
        }
    }
}

final class BookAPIService {
    private let baseURL = "https://www.googleapis.com/books/v1/volumes"

    // MARK: - Public Function: Search Books
    func searchBooks(query: String) async throws -> [Book] {
        let data = try await fetchData(for: query)
        let response = try decodeResponse(from: data)
        let books = mapToBooks(response)
        return books
    }

    // MARK: - Private Helpers

    private func fetchData(for query: String) async throws -> Data {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { throw BookAPIError.invalidQuery }

        guard let encodedQuery = trimmed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)?q=\(encodedQuery)&maxResults=20") else {
            throw BookAPIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw BookAPIError.requestFailed(statusCode: httpResponse.statusCode)
        }

        guard !data.isEmpty else { throw BookAPIError.noData }
        return data
    }

    private func decodeResponse(from data: Data) throws -> GoogleBooksResponse {
        do {
            let decoded = try JSONDecoder().decode(GoogleBooksResponse.self, from: data)
            return decoded
        } catch {
            throw BookAPIError.decodingError
        }
    }

    private func mapToBooks(_ response: GoogleBooksResponse) -> [Book] {
        guard let items = response.items else { return [] }

        return items.compactMap { item in
            let info = item.volumeInfo
            let title = info.title
            let author = info.authors?.first ?? "Unknown Author"
            
            // prefer httpsa
            var imageURLString = info.imageLinks?.thumbnail ?? info.imageLinks?.smallThumbnail ?? ""
            if imageURLString.hasPrefix("http://") {
                imageURLString = imageURLString.replacingOccurrences(of: "http://", with: "https://")
            }
            let coverURL = URL(string: imageURLString)
            
            return Book(title: title, author: author, coverURL: coverURL)
        }
    }
}
