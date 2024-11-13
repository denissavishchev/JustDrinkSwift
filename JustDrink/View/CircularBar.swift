import SwiftUI

struct CircularBar: View {
    
    var value: Double
    var total: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 16)
                .frame(width: 173, height: 173)
                .foregroundColor(.gray)
                .shadow(color: .white.opacity(0.2), radius: 10, x: -5, y: -5)
            
            Circle()
                .stroke(lineWidth: 29)
                .frame(width: 160, height: 160)
                .foregroundStyle(RadialGradient(gradient: Gradient(colors: [.gray, .black]),
                                                center: .center, startRadius: 15, endRadius: 100))
                .overlay {
                    Circle()
                        .frame(width: 133, height: 133)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.7), .white.opacity(0.15)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                }
            
            Circle()
                .stroke(lineWidth: 0.1)
                .frame(width: 189, height: 189)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white.opacity(0.7), .white.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            
            Circle()
                .stroke(lineWidth: 0.1)
                .frame(width: 133, height: 156)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.clear, .white.opacity(0.7)]), startPoint: .bottomTrailing, endPoint: .topLeading))
            
            Circle()
                .trim(from: 0, to: (value * 1000 / total))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .frame(width: 161, height: 161)
                .rotationEffect(.degrees(-90))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.customBlue, .customNavy]), startPoint: .topLeading, endPoint: .bottomTrailing))
            
            ZStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .shadow(color: .white.opacity(0.3), radius: 10, x: -10, y: -1)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white.opacity(0.1), .black]), startPoint: .bottomLeading, endPoint: .topTrailing))
                
                Circle()
                    .stroke(lineWidth: 0.1)
                    .frame(width: 40, height: 40)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white.opacity(0.1), .white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Image("Water")
                    .resizable()
                    .foregroundColor(.customBlue.opacity(0.9))
                    .frame(width: 21, height: 21)
            }
            .padding(.bottom, 53)
            
            Text("\(Int((value * 1000).rounded())) ml")
                .font(.title)
                .foregroundColor(.customBlue)
                .padding(.top, 53)
        }
        .padding(.bottom, 20)
        .padding(.top, 7)
    }
}

