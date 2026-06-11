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
    
    private let theme: AppTheme = .sunny
    
    var body: some View {
        
            ZStack {
                // MARK: App Background
                Image(theme.backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                theme.backgroundOverlay
                    .ignoresSafeArea()
                
                // MARK: Glassmorphism Logo Card
                VStack(spacing: 24) {
                    Image(systemName: "cloud.sun.fill")
                        .font(.system(size: 80))
                        .symbolRenderingMode(.multicolor)
                        .shadow(radius: 10)
                    
                    Text("SkyGlass")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(theme.primaryTextColor)
                        .tracking(3)
                }
                .padding(40)
                // 👈 هنا استخدمنا الستايل الزجاجي بتاعك عشان تندمج مع التطبيق
                .glassStyle(cornerRadius: 30, theme: theme, opacity: 0.3)
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
