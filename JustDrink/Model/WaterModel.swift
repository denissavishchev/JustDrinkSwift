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
    var type: Int
    var date: Date
    
    init(ml: String = "", type: Int = 1, date: Date = .now) {
        self.ml = ml
        self.type = type
        self.date = date
    }
}
