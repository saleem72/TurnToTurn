//
//  ColumnChartView.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/17/22.
//

import SwiftUI



struct GraphColumnsChartView<T: GraphColumnsChartItem>: View {
    
    let data: [T]
    let unit: String
    let verticalSteps: Int = 4
    let verticalGap: CGFloat = 32
    let horizontalGap: CGFloat = 24
    let font: Font = Font.gallery.medium(12)
    
    @State private var size: CGSize = .zero
    @State private var contentSize: CGSize = .zero
    
    var maxValue: CGFloat {
        let max = data.map({$0.value}).max() ?? 0
        return max.nextComplete
    }
    
    var body: some View {
        ZStack {
            legend
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .font(font)
        .background(
            GeometryReader {proxy -> Color in
                DispatchQueue.main.async {
                    self.size = proxy.size
                    self.contentSize = CGSize(width: proxy.size.width - horizontalGap, height: proxy.size.height - verticalGap)
                }
                return Color.clear
            }
        )
        .foregroundColor(.white)
    }
    
    func getDash(for idx: Int) -> CGFloat {
        maxValue -
            (maxValue * (CGFloat(idx) * CGFloat(1) / CGFloat(verticalSteps)))
    }
    
    func getColumnHeight(for value: CGFloat) -> CGFloat {
        value * contentSize.height / maxValue
    }
}


struct TestColumnChartView: View {
    
    var data: [DailyCrossedDistance] = DailyCrossedDistance.mockData
    
    
    var body: some View {
        ZStack {
            LinearGradient.screen
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                GraphColumnsChartView(data: data, unit: "KM")
                    .frame(height: 300)
            }
            .padding()
        }
    }
    
    
}

struct ColumnChartView_Previews: PreviewProvider {
    static var previews: some View {
        TestColumnChartView()
            .preferredColorScheme(.dark)
    }
}

extension GraphColumnsChartView {
    private var content: some View {
        ZStack {
            HStack(alignment: .bottom, spacing: 0) {
                let itemWidth = contentSize.width / CGFloat(data.count)
                ForEach(data.indices) { idx in
                    ZStack(alignment: .bottom) {
                        GraphColumnView(width: itemWidth - 16, height: getColumnHeight(for: data[idx].value), index: idx)
                    }
                    .frame(width: itemWidth)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .greedyView(alignment: .bottom)
        }
        .greedyView()
    }
}

extension GraphColumnsChartView {
    
    private var horizontalDashes: some View {
        HStack(spacing: 0) {
            let itemWidth = contentSize.width / CGFloat(data.count)
            ForEach(data.indices) { idx in
                ZStack(alignment: .top) {
//                    VStack {
                        Text(data[idx].label)
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                        
//                        Text(Double(data[idx].value).toDistance)
//                    }
                }
                .frame(width: itemWidth)
                .frame(maxHeight: .infinity)
            }
        }
        .greedyView(alignment: .leading)
    }
    
    private var verticalDashes: some View {
        VStack(alignment: .leading, spacing: 0) {
            let itemHeight = (contentSize.height) / CGFloat(verticalSteps)
            ForEach(0..<verticalSteps, id:\.self) { idx in
                let value = getDash(for: idx)
                ZStack(alignment: .topLeading) {
                    Text((value / 1000).removeExtraZeros())
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .frame(height: itemHeight, alignment: .topLeading)
            }
        }
        .frame(width: horizontalGap)
        .frame(maxHeight: .infinity, alignment: .bottomLeading)
    }
    
    private var axis: some View {
        ZStack {
            // X axis
            Rectangle()
                .frame(width: 2)
                .offset(x: -size.width / 2)
            
            // Y axis
            Rectangle()
                .frame(height: 2)
                .offset(y: size.height / 2)
            
        }
    }
    
    private var legend: some View {
        ZStack {
//            axis
            ZStack(alignment: .topLeading) {
                verticalDashes
                    .frame(height: contentSize.height)
//                    .background(Color.green)
            }
            .greedyView(alignment: .topLeading)
            
            ZStack(alignment: .bottomTrailing) {
                horizontalDashes
                    .frame(width: contentSize.width, height: verticalGap)
//                    .background(Color.yellow)
            }
            .greedyView(alignment: .bottomTrailing)
            
            ZStack(alignment: .topTrailing) {
                
                content
                    .frame(width: max(0, size.width - horizontalGap), height: max(0, size.height - verticalGap))
            }
            .greedyView(alignment: .topTrailing)
        }
        .greedyView()
    }
}

