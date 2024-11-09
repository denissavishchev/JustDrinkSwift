import SwiftUI

struct CircularBar: View {
    
    var value: Double
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 24)
                .frame(width: 260, height: 260)
                .foregroundColor(.gray)
                .shadow(color: .white.opacity(0.2), radius: 10, x: -10, y: -10)
            Circle()
                .stroke(lineWidth: 44)
                .frame(width: 240, height: 240)
                .foregroundStyle(RadialGradient(gradient: Gradient(colors: [.gray, .black]),
                                                center: .center, startRadius: 15, endRadius: 150))
                .overlay{
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.7), .white.opacity(0.15)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                }
            Circle()
                .stroke(lineWidth: 0.1)
                .frame(width: 284, height: 284)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white.opacity(0.7), .white.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            Circle()
                .stroke(lineWidth: 0.1)
                .frame(width: 200, height: 234)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.clear, .white.opacity(0.7)]), startPoint: .bottomTrailing, endPoint: .topLeading))
            Circle()
                .trim(from: 0, to: value)
                .stroke(style: StrokeStyle(lineWidth: 30, lineCap: .round))
                .frame(width: 242, height: 242)
                .rotationEffect(.degrees(-90))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.customBlue, .customNavy]), startPoint: .topLeading, endPoint: .bottomTrailing))
            ZStack{
                Circle()
                    .frame(width: 60, height: 60)
                    .shadow(color: .white.opacity(0.3), radius: 10, x: -10, y: -1)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white.opacity(0.1), .black]), startPoint: .bottomLeading, endPoint: .topTrailing))
                Circle()
                    .stroke(lineWidth: 0.1)
                    .frame(width: 60, height: 60)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white.opacity(0.1), .white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                Image("Drop")
                    .resizable()
                    .foregroundColor(.customBlue.opacity(0.9))
                    .frame(width: 32, height: 32)
                    
            }
            .padding(.bottom, 80)
            Text("\(Int((value * 1000).rounded())) ml")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.customBlue)
                .padding(.top, 80)
        }
        .padding(.vertical, 30)
    }
}

#Preview {
    CircularBar(value: 0.0)
}
