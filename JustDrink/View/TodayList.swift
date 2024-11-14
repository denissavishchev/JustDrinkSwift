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
    @Query(sort: [SortDescriptor(\WaterModel.date, order: .reverse)]) private var waterList: [WaterModel]
    @Environment(\.modelContext) private var modelContext
    let customFormat = Date.FormatStyle()
        .month(.abbreviated)
        .day(.twoDigits)
        .hour(.defaultDigits(amPM: .abbreviated))
        .minute(.twoDigits)
    @Binding var filteredWaterList: [WaterModel]
    
    private func fetchTodayWater() {
            let todayStart = Calendar.current.startOfDay(for: Date())
            let todayEnd = Calendar.current.date(byAdding: .day, value: 1, to: todayStart)!
            
            do {
                let fetchedWaterList = try modelContext.fetch(
                    FetchDescriptor<WaterModel>(
                        predicate: #Predicate { $0.date >= todayStart && $0.date < todayEnd},
                        sortBy: [SortDescriptor(\WaterModel.date, order: .reverse)]
                    )
                )
                filteredWaterList = fetchedWaterList
            } catch {
                print("Failed to fetch data: \(error)")
            }
        }
    
    var body: some View {
        List{
            ForEach(filteredWaterList) { water in
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
        .onAppear {
            fetchTodayWater()
            refreshValue()
                }
    }
    
    func deleteWater(_ water: WaterModel) {
        modelContext.delete(water)
        saveContext()
        fetchTodayWater()
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
            for water in filteredWaterList {
                value += Double(water.ml) ?? 0
            }
        }
        value = value / 1000
    }
    
}
