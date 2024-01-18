//
//  CoinRowView.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 05/08/2023.
//

import SwiftUI

struct CoinRowView: View {

    let coin: CoinModel
    let showHoldingColumn: Bool
    
    var body: some View {
        HStack(spacing: 0){
            leftColumn
                    Spacer()
            if showHoldingColumn {
                centerColumn
            }
            lastCloumn
        }
        .font(.subheadline)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin, showHoldingColumn: false)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        .padding()
    }
}

extension CoinRowView{
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.subheadline)
                .foregroundColor(Color.theme.secondaryText)
            .padding(.trailing, 10)
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
                .padding(.trailing, 7)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack {
            Text(coin.currentHoldingValue.asCurrencyWith2Digit())
                .bold()
            Text(coin.currentHolding?.asNumberString() ?? "0.0")
        }
        .foregroundColor(Color.theme.accent)
    }
    
    private var lastCloumn: some View {
        VStack {
            Text(coin.currentPrice.asCurrencyWith6Digit())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "0.0%")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing )
    }
    
}
