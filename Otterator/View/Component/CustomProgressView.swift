//
//  CustomProgressView.swift
//  Otterator
//
//  Created by Christopher Julius on 13/07/24.
//

import SwiftUI

struct CustomProgressView: View {
    @Binding var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 8)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(
                        width: min(progress * geometry.size.width,
                                   geometry.size.width),
                        height: 8
                    )
                    .foregroundColor(.black)
                Circle()
                    .frame(width:16,height:16)
                    .offset(x: min(progress * geometry.size.width,
                                   geometry.size.width) - 10)
            }
            .onTapGesture(coordinateSpace: .local){ location in
                withAnimation(.easeInOut){
                    progress = min(location.x / geometry.size.width,1)
                }
            }
        }
    }
}

#Preview {
    @State var progress:CGFloat = 0
    return CustomProgressView(progress: $progress)
}
