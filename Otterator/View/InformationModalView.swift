//
//  InformationModalView.swift
//  Otterator
//
//  Created by Christopher Julius on 13/07/24.
//

import SwiftUI

struct InformationModalView: View {
    @Environment(\.dismiss) var dismiss
    var info:[String:String] = [
        "Bold" : "Describing the part where your volume is High",
        "Normal" : "Describing the part where your volume is low",
        "Uppercase" : "Describing the part where your pace is slow",
        "Lowercase" : "Describing the part Where your pace is normal",
        "Light Blue Background" : "Describing the part where your pitch is low",
        "White Background" : "Describing the part where your pitch is normal",
        "Light Orange Background" : "Describing the part where your pitch is high",
        "//" : "Describing the pause you have in your presentation"
    ]
    var key = ["Bold","Normal","Uppercase","Lowercase","Light Blue Background","White Background","Light Orange Background","//"]
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                ForEach(key,id:\.self){ key in
                    Text(key)
                        .font(.custom("Playpen Sans",size:20))
                        .fontWeight(key == "Bold" ? .bold:.regular)
                        .textCase(key == "Uppercase" ? .uppercase:.lowercase)
                        .padding(.horizontal,4)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(key == "Light Blue Background" ? Color(hex: "00A3FF").opacity(0.3) : key == "Light Orange Background" ? Color(hex:"#FF8D23").opacity(0.3) : Color.clear)
                        }
                    Text(info[key] ?? "")
                        .font(.custom("Playpen Sans",size:16))
                        .padding(.bottom,8)
                }
            }
            .padding(.top,8)
            .padding(.horizontal,16)
            Spacer()
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Close"){
                        dismiss()
                    }
                }
            }
            .navigationTitle("Information")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    @State var isPresented = true
    return InformationModalView()
}
