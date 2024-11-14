//
//  HistoryList.swift
//  JustDrink
//
//  Created by Devis on 13/11/2024.
//

import SwiftUI
import SwiftData

struct HistoryList: View {
    
    @Query(sort: [SortDescriptor(\WaterModel.date, order: .forward)]) private var waterList: [WaterModel]
    let customFormat = Date.FormatStyle()
        .month(.abbreviated)
        .day(.twoDigits)
    var body: some View {
        
        let groupedWaterList = groupWaterByDate(waterList).reversed()
        
        VStack{
            ScrollView(.horizontal){
                HStack(alignment: .bottom){
                    ForEach(groupedWaterList, id: \.key) { date, waterOnDate in
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 50, height: (waterOnDate.reduce(0) { $0 + (Double($1.ml) ?? 0) }) <= 3000 ? ((waterOnDate.reduce(0) { $0 + (Double($1.ml) ?? 0) }) / 15) : 200)
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .customNavy]), startPoint: .bottom, endPoint: .top))
                                .overlay{
                                    Text("\(date.formatted(customFormat))")
                                        .foregroundStyle(.white)
                                }
                        }
                    }
                }
            }
//            .rotationEffect(.degrees(180))
            .padding()
        }
//        .listStyle(PlainListStyle())
//        .background(Color.black)
//        .scrollContentBackground(.hidden)
    }
    
    
    func groupWaterByDate(_ waterList: [WaterModel]) -> [(key: Date, value: [WaterModel])] {
           let grouped = Dictionary(grouping: waterList) { (water: WaterModel) -> Date in
               return Calendar.current.startOfDay(for: water.date)
           }
           return grouped.sorted { $0.key > $1.key }
       }
}

