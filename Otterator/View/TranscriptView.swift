//
//  TranscriptView.swift
//  Otterator
//
//  Created by Christopher Julius on 12/07/24.
//

import SwiftUI
import AVFAudio

struct TranscriptView: View {
    @State var segment = "Transcript"
    @State var isPlay = false
    @State var progress:CGFloat = 0
    @State var isPresented:[Bool] = [false,false,false]
    @State var modal = ""
    
    @State var viewModel = TranscriptViewModel()
    
    var tabs = ["Transcript","Summary"]
    var body: some View {
        NavigationStack{
            VStack{
                Picker("segment",selection:$segment){
                    ForEach(tabs, id:\.self){
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding(16)
                
                if segment == "Transcript" {
                    TranscriptContentView(viewModel: viewModel)
                } else {
                    VStack{
                        Spacer()
                        Text("Summary Page")
                        Spacer()
                    }
                }
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
}

#Preview {
    return TranscriptView()
}
