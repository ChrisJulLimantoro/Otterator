//
//  SummaryCardView.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 17/07/24.
//

import SwiftUI

struct SummaryCardView: View {
    var areaName: String
    var areaAverage: String = "AVERAGE"
    var areaValue: String
    
    @State var showTipsnTricks = false
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                HStack {
                    VStack (alignment: .leading) {
                        Text(areaName)
                            .font(Font.custom("PlaypenSans", size: 20))
                            .bold()
                            .foregroundStyle(.white)
                        HStack {
                            Text(areaAverage)
                                .font(Font.custom("PlaypenSans", size: 12))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                            Spacer()
                            Text(areaValue)
                                .font(Font.custom("PlaypenSans", size: 15))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                    }
                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
                .padding()
                .frame(width: 341, height: 70)
                .background(CardBackground(bgcolor: .blue))
                .onTapGesture {
                    withAnimation {
                        showTipsnTricks.toggle()
                    }
                }
                .zIndex(1.0)
                
                VStack (alignment: .leading, spacing: 6) {
                    Text("Tips")
                        .font(Font.custom("PlaypenSans", size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text(pitchTips["monotone"]!)
                        .font(Font.custom("PlaypenSans", size: 14))
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    SummaryCardView(areaName: "Pitch", areaValue: "200 Hz")
}

let pitchTips:[String:String] = [
    "monotone" : "A monotone delivery can quickly lull your audience to sleep. To keep your presentation engaging, make sure to modulate your pitch throughout your talk. Raise your pitch slightly when emphasizing key points and lower it when explaining details. This simple variation in pitch will add emphasis to your message and help keep your audience engaged.",
    "tooHigh" : "A squeaky-high pitch can be grating to your audience and make you sound nervous or lacking in confidence. To gain control over your pitch, employ diaphragmatic breathing techniques into your practice. Take deep breaths and exhale slowly while speaking. This will help you project a deeper, more resonant voice.",
    "tooLow" : "A voice that's too low can make your audience struggle to hear you and come across as lazy or unenthusiastic. To project your voice without raising your pitch, practice projecting your voice to the back of the room. This will help you increase your pitch without straining your vocal cords or raising your pitch unnaturally."
]

var pitchTricks:[String:String] = [
    "monotone" : "Practice reading your script aloud using different pitches. Listen back to your recordings to get a sense of how pitch variation can make your presentation more dynamic. This self-assessment will help you identify areas where you can improve your pitch modulation and deliver a more engaging presentation.",
    "tooHigh" : "Pay attention to situations that tend to trigger your high-pitched voice, such as nervousness or anxiety. When you find yourself in these situations, practice relaxation techniques like deep breathing or mindfulness exercises to calm your nerves and lower your pitch naturally.",
    "tooLow" : "Incorporate vocal exercises into your routine to find a lower pitch that's still comfortable and clear. Humming, scales, and tongue twisters can help you warm up your vocal cords and expand your vocal range, allowing you to project a clear and engaging voice without resorting to a strained high pitch."
]

