//
//  ChartView.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 10/08/2023.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let minY: Double
    private let maxY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        minY = data.min() ?? 0
        maxY = data.max() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            charkView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxis, alignment: .leading)
                
            charkDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView{
    
    private var charkView: some View{
        GeometryReader { geometryReader in
            Path{ path in
                for index in data.indices{
                    //xPostion and yPostion calculation example
                    /*
                     for example for xPostion
                     screen width = 300
                     data count = 100
                     300 / 100 = 3
                     index 0 -> 0 * 3 = 0
                     index 1 -> 1 * 3 = 3
                     index 2 -> 2 * 3 = 6
                     index 50 -> 50 * 3 = 150
                     
                     for example for yPostion
                     miny = 25000
                     maxY = 30000
                     yAix = 30000 - 25000 = 5000
                     26000 is data point
                     26000 - 25000 = 1000 / 5000 = 25%
                     
                     */
                    let xPostion = (geometryReader.size.width / CGFloat(data.count)) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPostion = (1 - CGFloat((data[index] - minY) / yAxis)) * geometryReader.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPostion, y: yPostion))
                    }
                    path.addLine(to: CGPoint(x: xPostion, y: yPostion))
                    
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineWidth: 3)
            .fill(lineColor)
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.25), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.12), radius: 10, x: 0.0, y: 40)
        }
    }
    
    private var chartBackground: some View{
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    private var chartYAxis: some View{
        VStack(content: {
            Text(maxY.formattedwithAbbreviations())
            Spacer()
            Text(((minY + maxY)/2).formattedwithAbbreviations())
            Spacer()
            Text(minY.formattedwithAbbreviations())
        })
    }
    
    private var charkDateLabels: some View{
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
