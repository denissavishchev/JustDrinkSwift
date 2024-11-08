import SwiftUI

struct CircularBar: View {
    
    var value: Double
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 24)
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 20)
            Circle()
                .stroke(lineWidth: 0.34)
                .frame(width: 175, height: 175)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.1), .clear]), startPoint: .bottomTrailing, endPoint: .topLeading))
            Circle()
                .trim(from: 0, to: value)
                .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round))
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        .padding(.vertical, 30)
    }
}

#Preview {
    CircularBar(value: 0.0)
}
