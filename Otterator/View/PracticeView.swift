//
//  PausePracticeView.swift
//  Otterator
//
//  Created by Alvin Lionel on 18/07/24.
//

import SwiftUI
import AVKit

struct PracticeView: View {
    @State private var tutorial = true
    @State var viewModel: PracticeViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            PracticeTranscript(viewmodel: viewModel)
            if tutorial{
                Color.black.opacity(0.7)
                VStack{
                    //                    VideoPlayer(player: AVPlayer(url: videoURL))
                    Image("TutorialPic")
                        .resizable()
                        .frame(width: 311, height: 200)
                    VStack{
                        Text("Tutorial")
                            .foregroundStyle(.primary)
                        Text("Try to match the pace and pause of the text")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Button(action: {
                            self.tutorial = false
                        },
                               label: {
                            Text("Ok!")
                        })
                        Spacer()
                    }
                    .frame(height: 200)
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: 311, height: 400)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
}
