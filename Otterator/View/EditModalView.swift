//
//  EditModalView.swift
//  Otterator
//
//  Created by Christopher Julius on 18/07/24.
//

import SwiftUI

struct EditModalView: View {
    @Binding var word:WordTranscript
    @Binding var save:Bool
    @State var change:String = ""
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused: Bool
    var body: some View {
        NavigationStack{
            Text("Editing the text")
                .font(.custom("Playpen Sans",size:16))
                .padding(.horizontal,16)
                .padding(.vertical,8)
            TextField(word.word,text: $change)
                .focused($isFocused)
                .textFieldStyle(.roundedBorder)
                .font(.custom("Playpen Sans",size:16))
                .padding(.horizontal,16)
                .onAppear(){
                    isFocused = true
                    change = word.corrected_word
                }
            Spacer()
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button(action: {
                        save = false
                        dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    })
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        word.corrected_word = change
                        save = true
                        dismiss()
                    }
                }
            }
            .navigationTitle("Edit Text")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}
