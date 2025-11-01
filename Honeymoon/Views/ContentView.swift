//
//  ContentView.swift
//  Honeymoon
//
//  Created by Ghenadie Isacenco on 01/11/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HeaderView()
            
            Spacer()
            
            CardView(honeymoon: honeymoonData[2])
            // FIX ME: - Add padding to the cards
                .padding()
            
            Spacer()
            
            
        }
    }
}

#Preview {
    ContentView()
}
