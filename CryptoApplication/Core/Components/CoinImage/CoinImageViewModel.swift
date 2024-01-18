//
//  CoinImageViewModel.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 06/08/2023.
//

import Foundation
import SwiftUI
import Combine

class coinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var Cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscription()
        self.isLoading = true
        
    }
    
    private func addSubscription(){
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnImage) in
                self?.image = returnImage
            }
            .store(in: &Cancellables)
    }
    
}
