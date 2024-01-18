//
//  XmarkButton.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 08/08/2023.
//

import SwiftUI

struct XmarkButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
        })
    }
}

struct XmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XmarkButton()
    }
}
