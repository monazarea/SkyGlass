//
//  GlassCardModifier.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//



import SwiftUI

struct GlassCardModifier: ViewModifier {
    let cornerRadius: CGFloat
    let glassOpacity: Double
    @EnvironmentObject private var themeManager: ThemeManager

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
                    .opacity(glassOpacity)
            )
            .environment(\.colorScheme, themeManager.currentTheme.primaryTextColor == .white ? .dark : .light)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(themeManager.currentTheme.primaryTextColor.opacity(0.15), lineWidth: 1)
            )
    }
}

extension View {
    
    func glassStyle(cornerRadius: CGFloat = 24, opacity: Double = 0.6) -> some View {
        self.modifier(GlassCardModifier(cornerRadius: cornerRadius, glassOpacity: opacity))
    }
}
