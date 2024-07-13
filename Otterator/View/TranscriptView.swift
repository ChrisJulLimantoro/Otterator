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
            ScrollView{
                VStack(alignment:.leading,spacing:24){
                    ForEach(0..<100){index in
                        HStack(alignment:.top,spacing:4){
                            Text("Hai")
                            Text("there")
                            Text("you")
                            Text("are")
                            Text("so")
                            Text("cool")
                            Text("i")
                            Text("like")
                            Text("you")
                            Text("very")
                            Text("much")
                        }
                    }
                }
            }
            .padding(8)
            Spacer()
            HStack(alignment:.center){
                Text("00:00")
                CustomProgressView(progress:$progress)
                    .frame(height:20)
                    .padding(.horizontal,16)
                Text("05:00")
            }
            .padding(.horizontal,16)
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
                        isPlay = !isPlay
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
                            // Action for the information
                        }) {
                            Label("Information", systemImage: "i.circle")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

#Preview {
    TranscriptView()
}
