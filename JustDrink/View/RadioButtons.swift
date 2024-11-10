//
//  RadioButtons.swift
//  JustDrink
//
//  Created by Devis on 10/11/2024.
//

import SwiftUI

struct RadioButtons: View {
    
    @State private var selectedItem: String = ""
    let icons = ["Water", "Tea", "Beer"]
    
    var body: some View {
        HStack(spacing: 24){
            ForEach(icons.indices, id:\.self){icon in
                ZStack{
                    Circle()
                        .stroke(lineWidth: 4)
                        .frame(width: 60, height: 60)
                        .foregroundStyle(selectedItem == icons[icon]
                                         ? LinearGradient(gradient: Gradient(colors: [.customNavy, .customBlue]),
                                                        startPoint: .bottom, endPoint: .top)
                                         : LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.7), .gray.opacity(0.6)]),
                                                         startPoint: .bottom, endPoint: .top))
                        .overlay{
                            Circle()
                                .frame(width: 56, height: 56)
                                .foregroundColor(.black)
                                .shadow(color: selectedItem == icons[icon] ? .clear : .black, radius: 10, x: 0, y: 10)
                        }
                    Image(icons[icon])
                        .resizable()
                        .frame(width: 30, height: 30).offset()
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: selectedItem == icons[icon]
                                                                           ? [.customNavy, .customBlue.opacity(0.6)]
                                                                           : [.gray.opacity(0.35), .gray]),
                                                        startPoint: .bottom, endPoint: .top))
                }
                .onTapGesture {
                    withAnimation{
                        selectedItem = icons[icon]
                    }
                }
            }
        }
    }
}

#Preview {
    RadioButtons()
}
