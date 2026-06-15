//
//  AlertSection.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//

import SwiftUI

struct AlertSection: View {
    let alertText: String
    let theme: AppTheme
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            
            Image(systemName: "exclamationmark.triangle")
                .font(.title3)
                .foregroundColor(.teal)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("WEATHER ALERT")
                    .font(.caption)
                    .fontWeight(.bold)
                    .tracking(1.5)
                    .foregroundColor(theme.primaryTextColor.opacity(0.6))
                
                Text(alertText)
                    .font(.subheadline)
                    .lineSpacing(4)
                    .foregroundColor(theme.primaryTextColor)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .environment(\.colorScheme, theme.primaryTextColor == .white ? .dark : .light)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(theme.primaryTextColor.opacity(0.15), lineWidth: 1) 
        )
    }
}
