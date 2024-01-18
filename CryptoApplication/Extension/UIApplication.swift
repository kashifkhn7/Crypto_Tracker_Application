//
//  UIApplication.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 08/08/2023.
//

import Foundation
import SwiftUI

extension UIApplication{
    
    func onEnding() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

