//
//  EditModalView.swift
//  Otterator
//
//  Created by Christopher Julius on 18/07/24.
//

import SwiftUI

struct EditModalView: View {
    @Binding var word:WordTranscript
    @State var change:String = ""
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused:Bool
    var body: some View {
        NavigationStack{
            TextField(word.word,text: $change)
                .focused(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=$isFocused@*/FocusState<Bool>().projectedValue/*@END_MENU_TOKEN@*/)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal,16)
            Spacer()
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    })
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        word.corrected_word = change
                        dismiss()
                    }
                }
            }
            .navigationTitle("Information")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(){
            isFocused = true
            change = word.corrected_word
            
        }
    }
}
