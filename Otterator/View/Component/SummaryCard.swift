//
//  SummaryCardView.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 17/07/24.
//

import SwiftUI

struct SummaryCard: View {
    var bgcolor: Color
    var areaName: String
    var areaResult : String
    var areaTips: String
    var areaTricks: String
    
    @State var showTipsnTricks = false
    
    var body: some View {
        //Card
        VStack /*(spacing: 12) */{
            
            HStack{
                Text(areaName)
                    .playpenSans(.bold, 20, .title3)
                    .foregroundStyle(.white)
                
                Spacer()
                Text(areaResult)
                    .playpenSans(.regular,20,.body)
                    .foregroundStyle(.white)
                    .padding(.trailing,8)
                Image(systemName: "chevron.down")
                    .font(Font.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .rotationEffect(.degrees(showTipsnTricks ? -180 : 0))
            }
            .padding()
            .background(CardBackground(bgcolor: bgcolor))
            .onTapGesture {
                withAnimation{
                    showTipsnTricks.toggle()
                }
            }
            //Tips n Tricks
            if showTipsnTricks {
                VStack (alignment: .leading,  spacing: 6) {
                    Text("Tips")
                        .playpenSans(.bold, 16, .headline)
                    Text(try!AttributedString(markdown: areaTips))
                        .playpenSans(.regular, 14, .body)
                }
                .padding()
                .background(
                    CardBackground(bgcolor: .white)
                )
                //Tricks
                VStack (alignment: .leading, spacing: 6) {
                    Text("Tricks")
                        .playpenSans(.bold, 16, .headline)
                    Text(try!AttributedString(markdown: areaTricks))
                        .playpenSans(.regular, 14, .body)
                }
                .padding()
                .background(
                    CardBackground(bgcolor: .white)
                )
            }
        }
        .padding()
    }
}
