//
//  JustDrinkApp.swift
//  JustDrink
//
//  Created by Devis on 08/11/2024.
//

import SwiftUI
import SwiftData

@main
struct JustDrinkApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
        .modelContainer(for: WaterModel.self)
        
    }
}
