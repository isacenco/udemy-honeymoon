//
//  HeaderView.swift
//  Honeymoon
//
//  Created by Ghenadie Isacenco on 01/11/2025.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - PROPERTIES
    @Binding var showGuideView: Bool
    @Binding var showInfoView: Bool
    
    var body: some View {
        HStack {
            Button {
                showInfoView.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .accentColor(.primary)
            .sheet(isPresented: $showInfoView) {
                InfoView()
            }

            Spacer()
            
            Image("logo-honeymoon-pink")
                .resizable()
                .scaledToFit()
                .frame(height: 28)
            
            Spacer()
            
            Button {
                showGuideView.toggle()
            } label: {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .accentColor(.primary)
            .sheet(isPresented: $showGuideView) {
                GuideView()
            }

        }
        .padding()
    }
}

#Preview(traits: .fixedLayout(width: 375, height: 80)) {
    @Previewable @State var showGuide: Bool = false
    @Previewable @State var showInfo: Bool = false
    HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
}
