//
//  TranscriptView.swift
//  Otterator
//
//  Created by Christopher Julius on 12/07/24.
//

import SwiftUI
import AVFAudio

struct TranscriptView: View {
    @State var segment = "Vocal"
    @State var isPlay = false
    @State var progress:CGFloat = 0
    @State var isPresented:[Bool] = [false,false,false]
    @State var edit:Bool = false
    
    @State var viewModel: TranscriptViewModel
    @State var word:WordTranscript = WordTranscript()
    
    var tabs = ["Vocal","Practice","Summary"]
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
                
                if segment == "Vocal" {
                    TranscriptContentView(viewModel: viewModel)
                } else if segment == "Practice"{
                    EditContentView(viewModel: viewModel,word: $word,edit: $edit)
                } else {
                    VStack{
                        SummaryView()
                    }
                }
            }
            .navigationTitle("Recording 001")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(hex:"#cce5ff"))
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Menu {
                        Button(action: {
                            
                        }){
                            Label("Rename File", systemImage: "square.and.pencil")
                        }
                        Button(action: {
                            // Action for the edit
                            print(viewModel.text.map{$0.corrected_word})
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
            .sheet(isPresented:$edit){
                EditModalView(word: $word)
                    .presentationDetents([.medium])
                    .presentationBackgroundInteraction(.disabled)
                    .presentationBackground(.ultraThickMaterial)
            }
        }
    }
}
