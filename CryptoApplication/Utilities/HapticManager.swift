//
//  HapticManager.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 09/08/2023.
//

import Foundation
import SwiftUI

class HapicManager{
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
    
}
