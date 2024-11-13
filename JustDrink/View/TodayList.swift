//
//  TodayList.swift
//  JustDrink
//
//  Created by Devis on 13/11/2024.
//

import SwiftUI
import SwiftData

struct TodayList: View {
    
    @Binding var value: Double
    @Query var waterList: [WaterModel]
    @Environment(\.modelContext) private var modelContext
    let customFormat = Date.FormatStyle()
        .month(.abbreviated)
        .day(.twoDigits)
        .hour(.defaultDigits(amPM: .abbreviated))
        .minute(.twoDigits)
    
    var body: some View {
        List{
            ForEach(waterList) { water in
                HStack {
                    VStack(alignment: .leading){
                        Text("Ml: \(water.ml)")
                            .foregroundColor(.white)
                        Text("Date: \(water.date.formatted(customFormat))")
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image("\(water.type)")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(LinearGradient(gradient: Gradient(
                            colors: [.customNavy, .customBlue.opacity(0.6)]),
                            startPoint: .bottom, endPoint: .top))
                }
                .frame(height: 30)
                .padding()
                .background(Color.black)
                .swipeActions {
                    Button(role: .destructive) {
                        deleteWater(water)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .listRowBackground(Color.black)
                .listRowSeparatorTint(.customBlue)
            }
        }
        .listStyle(PlainListStyle())
        .background(Color.black)
        .scrollContentBackground(.hidden)
    }
    
    func deleteWater(_ water: WaterModel) {
        modelContext.delete(water)
        saveContext()
        refreshValue()
    }
 
    func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    func refreshValue(){
        value = 0
        withAnimation{
            for water in waterList {
                value += Double(water.ml) ?? 0
            }
        }
        value = value / 1000
    }
    
}
