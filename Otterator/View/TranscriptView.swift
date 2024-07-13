//
//  TranscriptView.swift
//  Otterator
//
//  Created by Christopher Julius on 12/07/24.
//

import SwiftUI

struct TranscriptView: View {
    @State var segment = "Transcript"
    @State var isPlay = false
    @State var progress:CGFloat = 0
    @State var isPresented:[Bool] = [false,false,false]
    @State var modal = ""
    var duration:Double = 5
    var tabs = ["Transcript","Summary"]
    var body: some View {
        NavigationStack{
            Picker("segment",selection:$segment){
                ForEach(tabs, id:\.self){
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(16)
            CustomTranscript(progress:$progress)
            .padding(.horizontal,20)
            .padding(.vertical,8)
            Spacer()
            VStack{
                CustomProgressView(progress:$progress)
                    .frame(height:20)
                    .padding(.horizontal,16)
                HStack(alignment:.center){
                    Text(formatSec(progress * duration))
                    Spacer()
                    Text(formatSec(duration))
                }.padding(.horizontal,6)
            }
            .padding(.horizontal,16)
            .padding(.vertical,12)
            HStack{
                Spacer()
                Image(systemName:"gobackward.15")
                    .resizable()
                    .frame(width:40,height:40)
                Spacer()
                Image(systemName: !isPlay ? "play.fill" : "pause.fill")
                    .resizable()
                    .frame(width:40,height:40)
                    .onTapGesture{
                        withAnimation(.easeIn){
                            isPlay = !isPlay
                        }
                    }
                Spacer()
                Image(systemName:"goforward.15")
                    .resizable()
                    .frame(width:40,height:40)
                Spacer()
            }
            .navigationTitle("Recording 001")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Menu {
                        Button(action: {
                            
                        }){
                            Label("Rename File", systemImage: "square.and.pencil")
                        }
                        Button(action: {
                            // Action for the edit
                            
                        }) {
                            Label("Edit Content", systemImage: "pencil")
                        }
                        Button(action: {
                            isPresented[2] = true
                        }) {
                            Label("Information", systemImage: "i.circle")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented:$isPresented[2]){
                    InformationModalView()
                        .presentationDetents([.large])
                        .presentationBackgroundInteraction(.disabled)
                        .presentationBackground(.ultraThickMaterial)
            }
        }
    }
    func formatSec(_ second:Double) -> String
    {
        let totalSeconds = Int(floor(second))
        let minutes = totalSeconds / 60
        let remainingSeconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

#Preview {
    TranscriptView()
}
