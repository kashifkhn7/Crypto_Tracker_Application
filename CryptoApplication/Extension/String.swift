//
//  string.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 10/08/2023.
//

import Foundation

extension String{
    
    var removingHTMLOccurance: String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
