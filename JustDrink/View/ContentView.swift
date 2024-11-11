import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var waterList: [WaterModel]
    @Environment(\.modelContext) private var modelContext
    @State private var quantity: String = ""
    @State private var type: String = ""
    @State private var value = 0.75
    
    let customFormat = Date.FormatStyle()
        .month(.abbreviated)
        .day(.twoDigits)
        .hour(.defaultDigits(amPM: .abbreviated))
        .minute(.twoDigits)
    
    var body: some View {
        VStack{
            CircularBar(value: value, total: 3000)
            RadioButtons(selectedItem: $type)
            WaterButton(selectedItem: $quantity)
                .padding()
            ZStack{
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: .infinity, height: 60)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .customNavy]), startPoint: .leading, endPoint: .trailing))
                    .padding(EdgeInsets(top: 0, leading: 18, bottom: 18, trailing: 18))
                    .overlay{
                        Text("Add")
                            .foregroundStyle(.white)
                            .font(.title).bold()
                            .padding(.bottom, 18)
                    }
                RoundedRectangle(cornerRadius: 14)
                    .stroke(lineWidth: 1)
                    .frame(width: .infinity, height: 60)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white.opacity(0.7), .white.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .padding(EdgeInsets(top: 0, leading: 18, bottom: 18, trailing: 18))
            }
            .onTapGesture {
                addWater()
            }
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
        .background(Color.black)
        .onAppear {
            refreshValue()
        }
    }
       func addWater() {
           let newWater = WaterModel(ml: quantity, type: type, date: .now)
           modelContext.insert(newWater)
           saveContext()
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
        value = 0
        withAnimation{
            for water in waterList {
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
