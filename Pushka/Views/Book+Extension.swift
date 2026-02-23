//
//  Book+Extension.swift
//  Pushka
//
//  Created by Negi on 24/02/26.
//

import Foundation

extension Book {

    var bookStatus: BookStatus {
        get {
            BookStatus(rawValue: status ?? "") ?? .wantToRead
        }
        set {
            status = newValue.rawValue
        }
    }
}
