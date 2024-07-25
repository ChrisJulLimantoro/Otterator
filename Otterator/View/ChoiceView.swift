//
//  ChoiceView.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 25/07/24.
//

import SwiftUI

struct ChoiceView: View {
    var body: some View {
        VStack(alignment: .center) {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack{
                    Image(systemName: "doc.text.magnifyingglass")
                    Text("Start Practice")
                }.foregroundStyle(.white)
            }).background(CardBackground(bgcolor: .accent))
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack{
                    Image(systemName: "music.mic")
                    Text("Evaluate")
                }.foregroundStyle(.accent)
            }).background(CardBackground(bgcolor: .white))
        }
    }
}

#Preview {
    ChoiceView()
}
