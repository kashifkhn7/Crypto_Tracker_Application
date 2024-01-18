//
//  HomeView.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 05/08/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPorfolioView: Bool = false
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    @State private var showingSettingView: Bool = false
    
    
    var body: some View {
        ZStack{
            // background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPorfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            //content layer
            VStack{
                HomeHeader
                
                HomeStatisticView(showPorfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !showPortfolio{
                    if vm.allCoins.isEmpty {
                        allcoinsTextIfNotLoadedFromJSON
                    }else{
                        allCoinsList
                            .transition(.move(edge: .leading))
                    }
                }

                if showPortfolio{
                    ZStack(alignment: .top) {
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                            portfolioEmptyText
                        }else{
                            allPortfolioCoinsList
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showingSettingView, content: {
                SettingView()
            })
            .background(
                NavigationLink(
                    "",
                    destination: LoadingDetailView(coin: $selectedCoin),
                    isActive: $showDetailView)
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView{
    
    private var HomeHeader: some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info" )
                
                .onTapGesture {
                    if showPortfolio{
                    showPorfolioView.toggle()
                    }else{
                        showingSettingView.toggle()
                    }
            }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.subheadline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
    }
    
    private var allCoinsList: some View{
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var allcoinsTextIfNotLoadedFromJSON: some View{
        VStack {
            Spacer()
            Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .accentColor(Color.theme.secondaryText)
            Text("May be you have Network Issue or bad service from JSON Response site. Please try it later.")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.secondaryText)
                .multilineTextAlignment(TextAlignment.center)
            Spacer()
        }
        .padding(50)
    }
    
    private var allPortfolioCoinsList: some View{
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioEmptyText: some View{
        VStack {
            Spacer()
            Text("You haven't added any coins to your portfolio. Click the + botton to get started")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.secondaryText)
                .multilineTextAlignment(TextAlignment.center)
            .padding(50)
            Spacer()
        }
    }
    
    private func segue(coin: CoinModel){
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var columnTitles: some View{
        HStack(spacing: 4){
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    if vm.sortOption == .rank {
                        vm.sortOption = .rankReversed
                    }else{
                        vm.sortOption = .rank
                    }
                }
            }
            Spacer()
            if showPortfolio{
                HStack(spacing: 4) {
                        Text("Holding")
                        Image(systemName: "chevron.down")
                            .opacity((vm.sortOption == .holding || vm.sortOption == .holdingReversed) ? 1.0 : 0.0)
                            .rotationEffect(Angle(degrees: vm.sortOption == .holdingReversed ? 0 : 180))
                    }
                    .onTapGesture {
                        withAnimation(.default) {
                            if vm.sortOption == .holding {
                                vm.sortOption = .holdingReversed
                            }else{
                                vm.sortOption = .holding
                            }
                        }
                    }
            }
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    if vm.sortOption == .price {
                        vm.sortOption = .priceReversed
                    }else{
                        vm.sortOption = .price
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing )
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadCoin()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0))
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
