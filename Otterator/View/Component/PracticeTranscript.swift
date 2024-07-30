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
//        let gradient = LinearGradient(
//            gradient: Gradient(colors: [Color(hex:"#000000"), Color(hex:"#BFBFBF")]),
//            startPoint: .init(x:min(max(viewmodel.time-viewmodel.record.practice!.sorted(by: {$0.timestamp < $1.timestamp})[viewmodel.currentWordIndex].timestamp+viewmodel.record.practice!.sorted(by: {$0.timestamp < $1.timestamp})[viewmodel.currentWordIndex].duration,0)/viewmodel.record.practice!.sorted(by: {$0.timestamp < $1.timestamp})[viewmodel.currentWordIndex].duration,0.99),y:0.5),
//            endPoint: .init(x:min(max(viewmodel.time-viewmodel.record.practice!.sorted(by: {$0.timestamp < $1.timestamp})[viewmodel.currentWordIndex].timestamp+viewmodel.record.practice!.sorted(by: {$0.timestamp < $1.timestamp})[viewmodel.currentWordIndex].duration,0)/viewmodel.record.practice!.sorted(by: {$0.timestamp < $1.timestamp})[viewmodel.currentWordIndex].duration,1),y:0.5)
//        )
        
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack{
                        VStack(alignment: .leading){
                            if !viewmodel.fullSentence.isEmpty && viewmodel.currentWordIndex < viewmodel.fullSentence.count {
                                if viewmodel.currentWordIndex > 0{
                                    ForEach(0..<viewmodel.currentWordIndex, id: \.self) { index in
                                        if index < viewmodel.fullSentence.count{
                                            Text(viewmodel.fullSentence[index])
                                                .foregroundStyle(.secondary)
                                                .font(.system(size: 24, weight: .regular))
                                        }
                                    }
                                }
                                Text(viewmodel.fullSentence[viewmodel.currentWordIndex])
                                    .foregroundStyle(.primary)
                                    .font(.system(size: 24, weight: .regular))
                                    .id(viewmodel.currentWordIndex)
                                ForEach(viewmodel.currentWordIndex+1..<viewmodel.fullSentence.count, id: \.self) { index in
                                    if index < viewmodel.fullSentence.count{
                                        Text(viewmodel.fullSentence[index])
                                            .foregroundStyle(.secondary)
                                            .font(.system(size: 24, weight: .regular))
                                    }
                                }
                            }
                        }
                    }.scrollTargetLayout()
                }
                .onAppear {
                    self.proxy = proxy
                }
                .onChange(of: viewmodel.highlightedWord) {
                    withAnimation(){
                        self.proxy?.scrollTo(viewmodel.currentWordIndex)
                    }
                }
            }
            .padding(.horizontal,8)
            .background{
                CardBackground(bgcolor: .white)
            }
            .padding(.horizontal,20)
            .padding(.vertical,8)
            .frame(height: 587)
            .overlay{
                if viewmodel.isPause {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    VStack(alignment: .center){
                        Spacer()
                        ZStack{
                            Text("Pause")
                                .foregroundColor(.red)
                                .font(.system(size: 28, weight: .bold))
                                .id(0)
                            ring()
                                .frame(width: 200)
                                .animation(animation, value: viewmodel.drawingStroke)
                                .onAppear{
                                    viewmodel.drawingStroke.toggle()
                                }
                        }
                        Spacer()
                    }
                } else {
                    VStack{
                        
                    }
                    .onAppear{
                        viewmodel.drawingStroke.toggle()
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
            }.frame(height: 20)
                .padding(.horizontal, 6)
            
            HStack {
                Spacer()
                Button(action: {
                    if viewmodel.isPlaying {
                        viewmodel.pauseLyrics()
                    } else {
                        viewmodel.resumeLyrics()
                    }
                }, label: {
                    Image(systemName: viewmodel.isPlaying ? "pause.fill" : "play.fill")
                        .font(Font.custom("SF Pro", size: 26))
                        .foregroundStyle(Color.accentColor)
                        .background{
                            CircleButtonBackground(bgcolor: .white)
                        }
                })
                Spacer()
                Button(action: {
                    viewmodel.resetLyrics()
                    viewmodel.isPlaying = false
                }, label: {
                    Image(systemName: "gobackward")
                        .font(Font.custom("SF Pro", size: 26))
                        .foregroundStyle(Color.accentColor)
                        .background{
                            CircleButtonBackground(bgcolor: .white)
                        }
                })
                Spacer()
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
