//
//  WaterModel.swift
//  JustDrink
//
//  Created by Devis on 08/11/2024.
//

import Foundation
import SwiftData

@Model
class WaterModel{
    var ml: String
    var type: String
    var date: Date
    
    init(ml: String = "", type: String = "", date: Date = .now) {
        self.ml = ml
        self.type = type
        self.date = date
    }
}

enum Type: String, CaseIterable, Identifiable {
    case water, tea, beer
    var id: Self { self }

}


