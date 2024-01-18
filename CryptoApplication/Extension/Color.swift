//
//  Color.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 04/08/2023.
//

import Foundation
import SwiftUI

extension Color{
    
    static let theme = ColorTheme()
    static let launch = LaunchTheme()

    
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")

}

struct ColorTheme2 {
    let accent = Color.cyan
    let background = Color.yellow
    let green = Color.green
    let red = Color.red
    let secondaryText = Color.gray
}

struct LaunchTheme2 {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")

}

