//
//  PersistenceController.swift
//  Pushka
//
//  Created by Negi on 23/02/26.
//

import Foundation

import CoreData


struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Model")

        if let description = container.persistentStoreDescriptions.first {
            description.shouldMigrateStoreAutomatically = true
            description.shouldInferMappingModelAutomatically = true
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed: \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
