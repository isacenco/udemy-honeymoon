//
//  HeaderComponent.swift
//  Honeymoon
//
//  Created by Ghenadie Isacenco on 01/11/2025.
//

import SwiftUI

struct HeaderComponent: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Capsule()
                .frame(width: 120, height: 6)
                .foregroundColor(.secondary)
                .opacity(0.2)
            
            Image("logo-honeymoon")
                .resizable()
                .scaledToFit()
                .frame(height: 28)
        }
    }
}

#Preview(traits: .fixedLayout(width: 375, height: 128)) {
    HeaderComponent()
}
