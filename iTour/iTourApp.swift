//
//  iTourApp.swift
//  iTour
//
//  Created by temel gunaydin on 24.09.2024.
//

import SwiftData
import SwiftUI

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Destination.self)
        }
    }
}
