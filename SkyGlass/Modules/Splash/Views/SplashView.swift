//
//  SplashView.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    @EnvironmentObject private var themeManager: ThemeManager
    
    var body: some View {
        
            ZStack {
                // MARK: App Background
                Image(themeManager.currentTheme.backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                themeManager.currentTheme.backgroundOverlay
                    .ignoresSafeArea()
                
                // MARK: Glassmorphism Logo Card
                VStack(spacing: 24) {
                    Image(systemName: "cloud.sun.fill")
                        .font(.system(size: 80))
                        .symbolRenderingMode(.multicolor)
                        .shadow(radius: 10)
                    
                    Text("SkyGlass")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(themeManager.currentTheme.primaryTextColor)
                        .tracking(3)
                }
                .padding(40)
                .glassStyle(cornerRadius: 30, opacity: 0.3)
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeOut(duration: 1.2)) {
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        
    }
}
