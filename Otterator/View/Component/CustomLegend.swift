//
//  CustomLegend.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 26/07/24.
//

import SwiftUI

struct CustomLegend: View {
    var body: some View {
        VStack{
            HStack {
                Text("LEGEND").playpenSans(.bold, 14, .headline)
                Spacer()
            }.padding(.bottom, 4)
            HStack{
                Text(" fast pace ")
                    .playpenSans(.regular, 14, .body)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle( Color(hex:"#FF8D23").opacity(0.3))
                    }
                Spacer()
                Text("normal pace")
                    .playpenSans(.regular, 14, .body)
                Spacer()
                Text(" slow pace ")
                    .playpenSans(.regular, 14, .body)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle( Color(hex:"#00A3FF").opacity(0.3))
                    }
            }
            HStack{
                Spacer()
                Text("// pause")
                    .playpenSans(.regular, 14, .body)
                Spacer()
            }
        }
        .padding()
//        .background(CardBackground(bgcolor: .white))
    }
}

#Preview {
    CustomLegend()
}
