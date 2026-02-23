//
//  PushkaApp.swift
//  Pushka
//
//  Created by Admin on 31/08/25.
//

import SwiftUI

@main
struct PushkaApp: App {
    @StateObject private var homeVM = HomeViewModel()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(homeVM)
                .environment(\.managedObjectContext,
                                              persistenceController.container.viewContext)
        }
    }
}
