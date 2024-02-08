//
//  Daily_ZenApp.swift
//  Daily Zen
//
//  Created by Aditya Kumrawat on 08/02/24.
//

import SwiftUI

@main
struct Daily_ZenApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
