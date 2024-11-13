//
//  Button.swift
//  JustDrink
//
//  Created by Devis on 09/11/2024.
//

import SwiftUI

struct QuantityButtons: View {
    
    @Binding var selectedItem: String

    let ml = ["200", "300", "400", "500"]
    
    var body: some View {
        VStack(spacing: 16){
            ForEach(ml.indices, id:\.self){index in
                ZStack{
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .stroke(lineWidth: 10)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.1), .clear]), startPoint: .top, endPoint: .bottom))
                        
                    ZStack{
                        Text(ml[index])
                            .bold()
                            .font(.system(size: 22))
                            .foregroundColor(selectedItem == ml[index] ? .customNavy : .gray)
                            .padding(6)
                    }
                    .frame(width: 56, height: 56)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: .black.opacity(0.9), radius: 10, x: 0, y: 5)
                }
                .frame(width: 70, height: 70)
                .background(LinearGradient(gradient: Gradient(colors: selectedItem == ml[index]
                                                              ? [.customNavy, .customBlue]
                                                              : [.gray, .gray]),
                                           startPoint: .top, endPoint: .bottom))
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .onTapGesture {
                    withAnimation{
                        selectedItem = ml[index]
                    }
                }
            }
        }
    }
}

