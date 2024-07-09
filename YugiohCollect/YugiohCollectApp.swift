//
//  YugiohCollectApp.swift
//  YugiohCollect
//
//  Created by nwhitley.vendor on 6/3/24.
//

import SwiftUI
import SwiftData

@main
struct YugiohCollectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Card.self)
    }
}
