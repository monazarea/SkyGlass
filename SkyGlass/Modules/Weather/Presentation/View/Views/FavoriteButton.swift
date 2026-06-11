//
//  FavoriteButton.swift
//  SkyGlass
//
//  Created by Mona Zarea on 11/06/2026.
//

import SwiftUI
struct FavoriteButton: View {
    let isFavorite: Bool
    let theme: AppTheme
    let action: () -> Void
 
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 56, height: 56)
                    .overlay(
                        Circle()
                            .stroke(
                                theme.primaryTextColor.opacity(isFavorite ? 0.6 : 0.25),
                                lineWidth: 1
                            )
                    )
 
                Image(systemName: isFavorite ? "plus.circle.fill" : "plus.circle")
                    .font(.system(size: 26, weight: .medium))
                    .foregroundColor(
                        isFavorite
                            ? theme.primaryTextColor
                            : theme.primaryTextColor.opacity(0.7)
                    )
                    .scaleEffect(isFavorite ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isFavorite)
            }
        }
        .buttonStyle(.plain)
        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}
 
