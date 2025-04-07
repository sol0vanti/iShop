//
//  iShopApp.swift
//  iShop
//
//  Created by Alex Balla on 05.04.2025.
//

import SwiftUI
import Firebase


@main
struct iShopApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        FirebaseApp.configure()
        print("Configured FirebaseApp")
    }

    var body: some Scene {
        WindowGroup {
            AccountViewController()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
