//
//  Double.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 05/08/2023.
//

import Foundation


extension Double {
    
    
    /// convert a double into a currency 2 digits
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current // <- default value
//        formatter.currencyCode = "usd" // <- change curreny
//        formatter.currencySymbol = "$" // <- change currency symbol
        formatter.maximumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asCurrencyWith2Digit() -> String{
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    
    /// convert a double into a currency 2 to 6 digits
   /*
    numberFormatter.maximumFractionDigits = 0 // default
    numberFormatter.string(from: 123.456) // 123

    numberFormatter.maximumFractionDigits = 3
    numberFormatter.string(from: 123.456789) // 123.457
    
    */
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current // <- default value
//        formatter.currencyCode = "usd" // <- change curreny
//        formatter.currencySymbol = "$" // <- change currency symbol
        formatter.maximumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func asCurrencyWith6Digit() -> String{
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentString() -> String {
        return asNumberString() + "%" 
    }
    
    /*
     // Convert a double or long number into K, M, Bn, Tr Abbreviations
     //Convert 12 to 12.00
     // Convert 1234 to 1.23K
     // Convert 123456 to 123.45k
     / Convert 12345678 to 12.34M
     / Convert 1234567890 to 1.23Bn
     / Convert 123456789012 to 123.45Bn
     / Convert 12345678901234 to 12.34Tr
     */
    
    func formattedwithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()
            
        default:
            return "\(sign)(self)"
        }
    }
    
}
