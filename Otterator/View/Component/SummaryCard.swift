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
    var areaValue: String
    var areaTips: String
    var areaTricks: String
    
    @State var showTipsnTricks = false
    
    var body: some View {
        //Card
        VStack (spacing: 12) {
            //Area (Pitch)
            HStack {
                VStack (alignment: .leading) {
                    Text(areaName)
                        .playpenSans(.bold, 20)
                        .foregroundStyle(.white)
                    
                    Text(areaAverage)
                        .font(Font.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                }
                Spacer()
                Text(areaValue)
                    .playpenSans(.bold, 20)
                    .foregroundStyle(.white)
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
                        .playpenSans(.bold, 16)
                    Text(areaTips)
                        .playpenSans(.regular, 14)
                }
                .padding()
                .background(
                    CardBackground(bgcolor: .white)
                )
                //Tricks
                VStack (alignment: .leading, spacing: 6) {
                    Text("Tricks")
                        .playpenSans(.bold, 16)
                    Text(areaTricks)
                        .playpenSans(.regular, 14)
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
    SummaryCard(bgcolor: .blue,areaName: "Pitch", areaValue: "200 Hz", areaTips: "hei", areaTricks: "hei")
}
