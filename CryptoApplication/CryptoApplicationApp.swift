//
//  CryptoApplicationApp.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 04/08/2023.
//

import SwiftUI

@main
struct CryptoApplicationApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchScreen: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]

    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView{
                    HomeView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(vm)
                ZStack {
                    if showLaunchScreen {
                        LaunchView(showLaunchScreen: $showLaunchScreen)
                            .transition(.move(edge: .leading))
                    }
                }
                
            }
        }
    }
}
