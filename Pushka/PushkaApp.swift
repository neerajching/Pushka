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
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(homeVM)
        }
    }
}
