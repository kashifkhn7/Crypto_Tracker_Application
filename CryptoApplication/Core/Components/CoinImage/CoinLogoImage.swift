//
//  CoinLogoImage.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 08/08/2023.
//

import SwiftUI



struct CoinLogoImage: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack{
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(TextAlignment.center)
        }
    }
}

struct CoinLogoImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinLogoImage(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            CoinLogoImage(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
        }
        .padding()
    }
}

