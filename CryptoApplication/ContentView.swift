//
//  ContentView.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 04/08/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 20){
                Text("Accent color")
                    .foregroundColor(Color.theme.accent)
                
                Text("Green color")
                    .foregroundColor(Color.theme.green)
                
                Text("Red color")
                    .foregroundColor(Color.theme.red)
                
                Text("Secondary text color")
                    .foregroundColor(Color.theme.secondaryText)
            }
            .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
