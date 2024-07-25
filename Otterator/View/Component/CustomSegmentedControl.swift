//
//  CustomSegmentedControl.swift
//  Otterator
//
//  Created by Michelle Alvera Lolang on 24/07/24.
//

import SwiftUI

struct CustomSegmentedControl<Indicator: View>: View {
    var tabs: [SegmentedTab]
    @Binding var activeTab: SegmentedTab
    var height: CGFloat = 45
    var font: Font = .title3
    var activeTint: Color
    var inactiveTint: Color
    @ViewBuilder var indicatorView: (CGSize) -> Indicator
    @State private var excessTabWidth: CGFloat = .zero
    @State private var minX: CGFloat = .zero
    @Bindable var viewModel: TranscriptViewModel
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            let containerWidthForEachTab = size.width / CGFloat(tabs.count)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.rawValue) { tab in
                    Text(tab.rawValue)
                    .font(.playpenSans(.semiBold, 14, .caption))
                    .foregroundStyle(activeTab == tab ? activeTint : inactiveTint)
                    .animation(.snappy, value: activeTab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        if activeTab == .summary {
                            SummaryView(activeTab: .summary)                        } else {
                            TranscriptView(viewModel: viewModel)
                        }
                    }
                    .background {
                        if activeTab == tab {
                            GeometryReader {
                                let size = $0.size
                                
                                indicatorView(size)
                                    .frame(width: size.width, height: size.height, alignment: .center)
                            }
                        }
                    }
                }
            }
            .background(RoundedRectangle(cornerRadius: 14).fill(Color(hex: "#decbc1")).shadow(color: Color(hex: "#555555"), radius: 0, x: 4, y: 4))
            .padding(.horizontal)
        }
        .frame(height: height)
    }
}

enum SegmentedTab: String, CaseIterable {
    case transcript = "Transcript"
    case summary = "Summary"
}

#Preview {
    ContentView()
}
