//
//  CustomProgressView.swift
//  Otterator
//
//  Created by Christopher Julius on 13/07/24.
//

import SwiftUI
import AVFoundation

struct CustomProgressView: View {
    @Bindable var viewModel:TranscriptViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 8)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(
                        width: min((viewModel.currentTime / viewModel.audio.duration) * geometry.size.width,
                                   geometry.size.width),
                        height: 8
                    )
                    .foregroundColor(.black)
                Circle()
                    .frame(width:16,height:16)
                    .offset(x: min((viewModel.currentTime / viewModel.audio.duration) * geometry.size.width,
                                   geometry.size.width) - 10)
            }
            .onTapGesture(coordinateSpace: .local){ location in
                withAnimation(.easeInOut){
                    viewModel.changeLocation(min(location.x / geometry.size.width,1) * viewModel.audio.duration)
                }
            }
        }
    }
}
