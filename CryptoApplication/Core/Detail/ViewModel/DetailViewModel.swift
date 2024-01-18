//
//  DetailViewModel.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 10/08/2023.
//

import Foundation
import Combine
class DetailViewModel: ObservableObject{
    
    @Published var overviewStatistic: [StatisticModel] = []
    @Published var additonalStatistic: [StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var coinHomepageLink: String? = nil
    @Published var coinRedditURLLink: String? = nil
    @Published var coin: CoinModel
    
    private let coinDetaildataservice: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetaildataservice = CoinDetailDataService(coin: coin)
        self.addSubscriber()
    }
    
    private func addSubscriber(){
        coinDetaildataservice.$coinDetail
            .combineLatest($coin)
            .map(mapDataToStatistic)
            .sink { [weak self] (returnedArray) in
                self?.overviewStatistic = returnedArray.overview
                self?.additonalStatistic = returnedArray.additional
            }
            .store(in: &cancellables)
        
        coinDetaildataservice.$coinDetail
            .sink { [weak self] (returnCoinDetail) in
                self?.coinDescription = returnCoinDetail?.readableDescroption
                self?.coinHomepageLink = returnCoinDetail?.links?.homepage?.first
                self?.coinRedditURLLink = returnCoinDetail?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistic(coinDetail: CoinDetailModel?, coin: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]){
        
        let overviewArray = createOverviewArray(coin: coin)
        let additionalArray = createAdditionalArray(coinDetail: coinDetail, coin: coin)
        
        return (overviewArray, additionalArray)
    }
    
    private func createOverviewArray(coin: CoinModel) -> [StatisticModel] {
        let currentPrice = coin.currentPrice.asCurrencyWith6Digit()
        let priceChange = coin.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: currentPrice, percentageChange: priceChange)
        
        let marketCap = "$" + (coin.marketCap?.formattedwithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitaliztion", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coin.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volumn = "$" + (coin.totalVolume?.formattedwithAbbreviations() ?? "")
        let volumnStat = StatisticModel(title: "Volumn", value: volumn)
        
        let overviewArray: [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumnStat
        ]
        return overviewArray
    }
    
    private func createAdditionalArray(coinDetail: CoinDetailModel?, coin: CoinModel) -> [StatisticModel]{
    let high = coin.high24H?.asCurrencyWith6Digit() ?? "n/a"
    let highStat = StatisticModel(title: "24h High", value: high)
    
    let low = coin.low24H?.asCurrencyWith6Digit() ?? "n/a"
    let lowStat = StatisticModel(title: "24h Low", value: low)
    
    let priceChange24h = coin.priceChange24H?.asCurrencyWith6Digit() ?? "n/a"
    let pricePercentChange = coin.priceChangePercentage24H
    let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange24h, percentageChange: pricePercentChange)
    
    let marketCapChange = "$" + (coin.marketCapChange24H?.formattedwithAbbreviations() ?? "n/a")
    let marketCapPercentChange2 = coin.marketCapChangePercentage24H
    let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
    
    let blockTime = coinDetail?.blockTimeInMinutes ?? 0
    let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
    let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
    
    let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
    let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
    
    let additionalArray: [StatisticModel] = [
        highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
    ]
        return additionalArray
    }
}
