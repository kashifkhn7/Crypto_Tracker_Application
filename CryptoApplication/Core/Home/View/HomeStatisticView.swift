//
//  HomeStatisticView.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 08/08/2023.
//

import SwiftUI

struct HomeStatisticView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @Binding var showPorfolio: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            ForEach(vm.statistic) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3 )
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPorfolio ? .trailing : .leading)
    }
}

struct HomeStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatisticView(showPorfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
