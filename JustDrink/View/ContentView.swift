import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var waterList: [WaterModel]
    @Environment(\.modelContext) private var modelContext
    @State private var quantity: String = ""
    @State private var type: String = ""
    @State private var value = 0.75
    @State private var filteredWaterList: [WaterModel] = []
    
    
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
        VStack{
            HStack{
                Spacer()
                TypeButtons(selectedItem: $type)
                Spacer()
                VStack{
                    CircularBar(value: value, total: 3000)
                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .customNavy]), startPoint: .leading, endPoint: .trailing))
                            
                            .overlay{
                                Text("Add")
                                    .foregroundStyle(.white)
                                    .font(.title).bold()
                            }
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white.opacity(0.7), .white.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                    .frame(width: 100, height: 40)
                    .padding(EdgeInsets(top: 30, leading: 18, bottom: 8, trailing: 18))
                    .onTapGesture {
                        addWater()
                    }

                }
                Spacer()
                QuantityButtons(selectedItem: $quantity)
                Spacer()
            }
            TodayList(value: $value, filteredWaterList: $filteredWaterList)
            Divider()
                .background(.blue)
            HistoryList()
            
        }
        .background(Color.black)
        .onAppear {
            fetchTodayWater()
            refreshValue()
        }
    }
       func addWater() {
           let newWater = WaterModel(ml: quantity, type: type, date: .now)
           modelContext.insert(newWater)
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




#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: WaterModel.self, configurations: config)
        for i in 1..<1 {
               let ml = WaterModel(ml: "\(i)00")
               container.mainContext.insert(ml)
           }
        return ContentView()
            .modelContainer(container)
    } catch{
        fatalError("Failed to create model container")
    }
}
