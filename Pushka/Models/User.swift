//
//  User.swift
//  Pushka
//
//  Created by Admin on 31/08/25.
//

import Foundation
struct User : Identifiable, Codable {
    var id : UUID = UUID()
    var name : String
    var readingList: [UserBook] = []
}

enum BookStatus : String, Codable , CaseIterable , Identifiable{
    case wantToRead = "Want to Read"
    case currentlyReading = "Currently Reading"
    case read = "Read"
    var id: String { self.rawValue }
}

struct UserBook : Identifiable, Codable {
    var id : UUID = UUID()
    var title : String
    var author : String
    var coverURL : URL?
    var bookDescription: String? = nil
    var status: BookStatus = .wantToRead
}

//Google Books API Model
struct GoogleBooksResponse : Codable {
    let items : [GoogleBookItem]?
}

struct GoogleBookItem : Codable {
    let id : String
    let volumeInfo : VolumeInfo
}

struct VolumeInfo : Codable {
    let title  : String
    let authors : [String]?
    let imageLinks  : ImageLinks?
}

struct ImageLinks : Codable {
    let smallThumbnail: String?
    let thumbnail: String?
}

/**
 Book(
     title: volumeInfo.title ?? "Unknown Title",
     author: volumeInfo.authors?.first ?? "Unknown Author",
     coverURL: URL(string: volumeInfo.imageLinks?.thumbnail ?? "")
 )
 */


