//
//  iShopApp.swift
//  iShop
//
//  Created by Alex Balla on 05.04.2025.
//

import SwiftUI

@main
struct iShopApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
