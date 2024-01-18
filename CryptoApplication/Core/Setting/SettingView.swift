//
//  SettingView.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 10/08/2023.
//

import SwiftUI

struct SettingView: View {
    
    private let defaultURL: URL = URL(string: "http://www.google.com")!
    private let facebookURL: URL = URL(string: "http://www.facebook.com")!
    private let coinGeckoURL: URL = URL(string: "http://www.coingecko.com")!
    private let githubURL: URL = URL(string: "http://www.github.com")!

    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                
                List {
                    cryptoApplicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    developerSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
                .font(.headline)
                .accentColor(Color.blue)
                .listStyle(GroupedListStyle())
                .navigationTitle("Setting")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        XmarkButton()
                    })
                }
            }
        }
    }
}
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

extension SettingView{
    
    private  var cryptoApplicationSection: some View{
        Section(header: Text("Crypto Application")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This App was made by following a @Technologies. It uses a MVVM Architecture, Combine and CoreData.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)

            }
            .padding(.vertical, 4)
            Link("Follow to Facebook Page 🥳", destination: facebookURL)
        }
    }
    
    private  var coinGeckoSection: some View{
        Section(header: Text("coinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This cryptocurrency data that is used in this app comes from a free API free coinGecko Price may be slighly delayed")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)

            }
            .padding(.vertical, 4)
            Link("Visit coinGecko 🥳", destination: coinGeckoURL)
        }
    }
    
    private  var developerSection: some View{
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by Muhammad Kashif. It uses SwiftUI and is written 100% in Swift. This project benefits from multi-threading, subscriber/publisher and data persistance")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)

            }
            .padding(.vertical, 4)
            Link("Get Code From Github 🥳", destination: githubURL)
        }
    }
    
    private  var applicationSection: some View{
        Section(header: Text("Applicattion")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn more", destination: defaultURL)
        }

    }
    
}
