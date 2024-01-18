//
//  HomeViewModel.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 05/08/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistic: [StatisticModel] = []
    
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holding
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancelable = Set<AnyCancellable>()
    
    enum SortOption{
        case rank, rankReversed, holding, holdingReversed, price, priceReversed
    }

    init(){
        addSubscriber()
    }
    
    func addSubscriber(){
        
        // update allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSort)
            .sink { [weak self] (returnValue) in
                self?.allCoins = returnValue
            }
            .store(in: &cancelable)
        
        //Update portfolio
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinToPortfolioCoin)
            .sink { [weak self] (returnedCoin) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinIfNeeded(coins: returnedCoin)
            }
            .store(in: &cancelable)
        
        //update market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapMarketData)
            .sink { [weak self] returnedStats in
                self?.statistic = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancelable)
        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        portfolioDataService.updaingPortfolio(coin: coin, amount: amount)
    }
    
    func reloadCoin(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapicManager.notification(type: .success)
    }
    
    private func filterAndSort(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel]{
        var UpdatedCoin = filterCoin(text: text, coins: coins)
        sortCoin(sort: sort, coins: &UpdatedCoin)
        return UpdatedCoin
    }
    
    private func filterCoin(text: String, coins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        let lowercaseText = text.lowercased()
        return coins.filter { coin in
            return  coin.name.lowercased().contains(lowercaseText) ||
                    coin.symbol.lowercased().contains(lowercaseText) ||
                    coin.id.lowercased().contains(lowercaseText)
        }
    }
    
    private func sortCoin(sort: SortOption ,coins:  inout [CoinModel]){
        switch sort{
        case .rank, .holding:
            coins.sort(by: { $0.rank < $1.rank})
        case .rankReversed, .holdingReversed:
            coins.sort(by: { $0.rank > $1.rank})
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice})
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice})
        }
    }
    
    private func sortPortfolioCoinIfNeeded(coins: [CoinModel]) -> [CoinModel]{
        switch sortOption {
        case .holding:
            return coins.sorted(by: { $0.currentHoldingValue > $1.currentHoldingValue})
        case .holdingReversed:
            return coins.sorted(by: { $0.currentHoldingValue < $1.currentHoldingValue})
        default:
            return coins
        }
    }
    
    private func mapAllCoinToPortfolioCoin(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel]{
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id}) else {
                    return nil
                }
                return coin.updateHolding(amount: entity.amount)
            }
    }
    
    private func mapMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel]{
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volumn = StatisticModel(title: "24h Volumn", value: data.volumn)
        
        let btcDominance = StatisticModel(title: "BTCDominance", value: data.btcDominance)
        
        let portfolioValue =
                portfolioCoins
                    .map({ $0.currentHoldingValue})
                    .reduce(0, +)
        
        let previousValue    =
                portfolioCoins
                    .map { (coin) -> Double in
                        let currentValue = coin.currentHoldingValue
                        let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                        let previousValue = currentValue / (1 + percentChange)
                        return previousValue
            }
                    .reduce(0, +)
        
        // 110 / (1 + 0.1) -> 10
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.formattedwithAbbreviations()
            , percentageChange: percentageChange
        )
        
        stats.append(contentsOf:[
                        marketCap,
                     volumn,
                     btcDominance,
                     portfolio
        ])
        return stats
    }
    
}
