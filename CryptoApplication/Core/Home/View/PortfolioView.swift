//
//  PortfolioView.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 08/08/2023.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    SearchBarView(searchText: $vm.searchText)
                    
                    coinHorizontalListView
                    
                    if selectedCoin != nil {
                        portfolioInputSecton
                    }
                }
            }
            .background(Color.theme.background.ignoresSafeArea())
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButton
                }
            }
            .onChange(of: vm.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}


extension PortfolioView{
    
    private var coinHorizontalListView: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoImage(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            updateSelectedCoin(coin: coin)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear,
                                        lineWidth: 1
                                       )
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoin(coin: CoinModel){
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id}),
           let amount = portfolioCoin.currentHolding{
            quantityText = "\(amount)"
        }else{
            quantityText = ""
        }
    }
    
    
    private func getCurrentValue() -> Double{
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSecton: some View{
        VStack {
            HStack{
                Text("Current amount of \(selectedCoin?.symbol.uppercased() ?? "")")
                Spacer()
                Text("\(selectedCoin?.currentPrice.asCurrencyWith6Digit() ?? "")")
            }
            Divider()
            HStack{
                Text("Amount Holding:")
                Spacer()
                TextField("Ex: 1.5", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Digit())
                
            }
        }
        .animation(.none)
        .font(.headline)
        .padding()
    }
    
    private var trailingNavBarButton: some View{
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("save".uppercased())
            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHolding != Double(quantityText) ? 1.0 : 0.0)
        }
    }
    
    private func saveButtonPressed(){
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else { return }
        
        //save to the portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        //show check mark
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        //hide keyboard
        UIApplication.shared.onEnding()
        
        //hide Checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeOut){
                showCheckMark = false
            }
        }
        
        
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
    }
}
