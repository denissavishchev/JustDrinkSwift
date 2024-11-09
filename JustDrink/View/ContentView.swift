import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var waterList: [WaterModel]
    @Environment(\.modelContext) private var modelContext
    @State private var quantity: String = ""
    @State private var value = 0.75

    var body: some View {
        
        VStack{
            CircularBar(value: value)
//            TextField("Enter quantity", text: $quantity)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .keyboardType(.decimalPad)
//                .padding()
            
            HStack(spacing: 16){
                WaterButton(title: "200"){
                    print("200")
                }
                WaterButton(title: "300")
                {
                    print("300")
                }
                WaterButton(title: "400")
                {
                    print("400")
                }
                WaterButton(title: "500")
                {
                    print("500")
                }
            }
                .padding()
            List {
                ForEach(waterList) { water in
                    HStack {
                        Text("Quantity: \(water.ml)")
                        Spacer()
                        Text("Type: \(water.type)")
                        Spacer()
                        Text("Date: \(water.date.formatted(date: .long, time: .shortened))")
                        Spacer()
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteWater(water)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            
        }
        .background(Color.black)
//        .onAppear {
//            refreshValue()
//        }
    }
       func addWater() {
           let newWater = WaterModel(ml: quantity, type: 1, date: .now)
           modelContext.insert(newWater)
           saveContext()
           quantity = ""
           refreshValue()
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
        withAnimation{
            for water in waterList {
                print(water.ml)
                value += Double(water.ml) ?? 0
                print(value)
            }
        }
        value = value / 10000
        print(value)
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: WaterModel.self, configurations: config)
        for i in 1..<5 {
               let ml = WaterModel(ml: "\(i)00")
               container.mainContext.insert(ml)
           }
        return ContentView()
            .modelContainer(container)
    } catch{
        fatalError("Failed to create model container")
    }
}
