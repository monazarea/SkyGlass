//
//  GlassCardModifier.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//



import SwiftUI

struct GlassCardModifier: ViewModifier {
    let cornerRadius: CGFloat
    let theme: AppTheme
    let glassOpacity: Double
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
                    .opacity(glassOpacity)
            )
            .environment(\.colorScheme, theme.primaryTextColor == .white ? .dark : .light)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(theme.primaryTextColor.opacity(0.15), lineWidth: 1)
            )
    }
}

extension View {
    func glassStyle(cornerRadius: CGFloat = 24, theme: AppTheme, opacity: Double = 0.6) -> some View {
        self.modifier(GlassCardModifier(cornerRadius: cornerRadius, theme: theme, glassOpacity: opacity))
    }
}
