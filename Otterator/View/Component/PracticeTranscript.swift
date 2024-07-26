//
//  DummyPauseTranscript.swift
//  Otterator
//
//  Created by Alvin Lionel on 18/07/24.
//

import Foundation
import SwiftUI

struct PracticeTranscript: View {
    
    @State var proxy: ScrollViewProxy? = nil
    
    
    var animation: Animation {
        Animation.easeOut(duration: viewmodel.pauseDuration)
    }
    
    @Bindable var viewmodel: PracticeViewModel
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack{
                        if viewmodel.isPause {
                            VStack(alignment: .center){
                                Spacer()
                                ZStack{
                                    Text("Pause")
                                        .foregroundColor(.red)
                                        .font(.system(size: 36, weight: .bold))
                                        .id(0)
                                    ring()
                                        .frame(width: 300)
                                        .animation(animation, value: viewmodel.drawingStroke)
                                        .onAppear{
                                            viewmodel.drawingStroke.toggle()
                                        }
                                }
                                Spacer()
                            }
                        } else {
                            ZStack(alignment: .topLeading){
                                Text(viewmodel.fullSentence)
                                    .foregroundColor(.secondary)
                                    .font(.system(size: 24, weight: .regular))
                                Text(viewmodel.highlightedWord)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 24, weight: .regular))
                                    .id(viewmodel.currentWordIndex)
                            }
                            .frame(width: 360, alignment: .leading)
                            .onAppear{
                                viewmodel.drawingStroke.toggle()
                            }
                        }
                    }.scrollTargetLayout()
                }
                .onAppear {
                    self.proxy = proxy
                    print("full:", viewmodel.fullSentence)
                    print("high:", viewmodel.highlightedWord)
                }
                .onChange(of: viewmodel.highlightedWord) {
                    withAnimation(){
                        self.proxy?.scrollTo(viewmodel.currentWordIndex) //anchor: .top 
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Slider(value: Binding(
                    get: { Double(viewmodel.currentWordIndex) / Double(viewmodel.record.practice!.count) },
                    set: { newValue in
                        let newIndex = Int(newValue * Double(viewmodel.record.practice!.count))
                        if newIndex != viewmodel.currentWordIndex {
                            viewmodel.seekToWord(index: newIndex)
                        }
                    }
                ), in: 0...1)
                .padding()
            }
            
            HStack {
                Button(action: {
                    
                    if viewmodel.fullSentence.isEmpty {
                        viewmodel.startLyrics()
                    } else if viewmodel.isPlaying {
                        viewmodel.pauseLyrics()
                    } else {
                        viewmodel.resumeLyrics()
                    }
                    viewmodel.isPlaying.toggle()
                }, label: {
                    Text(viewmodel.isPlaying ? "Pause" : "Play")
                })
                .padding()
                .foregroundStyle(Color.white)
                .background(Color.blue)
                .clipShape(Capsule())
                
                Button(action: {
                    viewmodel.resetLyrics()
                    viewmodel.isPlaying = false
                }, label: {
                    Text("Reset")
                })
                .padding()
                .foregroundStyle(Color.white)
                .background(Color.blue)
                .clipShape(Capsule())
            }
            .padding()
        }
    }
    
    func ring() -> some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 16))
            .foregroundStyle(.tertiary)
            .overlay{
                Circle()
                    .trim(from: 0, to: viewmodel.drawingStroke ? 1 : 0)
                    .stroke(.red, style: StrokeStyle(lineWidth: 16, lineCap: .round))
            }
            .rotationEffect(.degrees(-90))
    }
}
