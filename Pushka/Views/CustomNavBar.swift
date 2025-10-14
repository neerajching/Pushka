//
//  CustomNavBar.swift
//  Pushka
//
//  Created by Admin on 13/10/25.
//

import SwiftUI

struct CustomNavBar: View {
    var title: String = "Library"
        
        var body: some View {
            ZStack {
                // ✅ Native SwiftUI blur background
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea(edges: .top)
                    .overlay(
                        Divider() // subtle separator at bottom
                            .background(Color.white.opacity(0.3)),
                        alignment: .bottom
                    )
                
                // 🧭 Content
                HStack {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    
                    Spacer()
                    
                    Button {
                        // ⚙️ Settings/Profile action
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.title3)
                            .foregroundStyle(.primary)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 50)  // for status bar safe area
                .padding(.bottom, 10)
            }
            .frame(height: 90)
        }
}

#Preview {
    CustomNavBar()
}
