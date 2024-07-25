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
    var areaAverage: String = "AVERAGE"
    var areaTips: String
    var areaTricks: String
    
    @State var showTipsnTricks = false
    
    var body: some View {
        //Card
        VStack /*(spacing: 12) */{
            //Area (Pitch)
            HStack{
                VStack (alignment: .leading) {
                    Text(areaName)
                        .playpenSans(.bold, 20, .title3)
                        .foregroundStyle(.white)
                    
                    Text(areaAverage)
                        .font(.caption)
                        .foregroundStyle(.white)
                }
                Spacer()
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
                    Text(areaTips)
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
                    Text(areaTricks)
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

#Preview {
    SummaryCard(bgcolor: .blue,areaName: "Pitch", areaTips: "Ini Tips", areaTricks: "Ini Tricks")
}
