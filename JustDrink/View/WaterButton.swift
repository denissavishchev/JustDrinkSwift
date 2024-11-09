//
//  Button.swift
//  JustDrink
//
//  Created by Devis on 09/11/2024.
//

import SwiftUI

struct WaterButton: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .stroke(lineWidth: 10)
            .frame(width: 80, height: 80)
            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.1), .clear]), startPoint: .top, endPoint: .bottom))
                
            ZStack{
                Text("300")
                    .bold()
                    .font(.system(size: 22))
                    .foregroundColor(.customNavy)
                    .padding(6)
            }
            .frame(width: 64, height: 64)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .black.opacity(0.9), radius: 10, x: 0, y: 5)
        }
        .frame(width: 80, height: 80)
        .background(LinearGradient(gradient: Gradient(colors: [.customNavy, .customBlue]), startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}

#Preview {
    WaterButton()
}
