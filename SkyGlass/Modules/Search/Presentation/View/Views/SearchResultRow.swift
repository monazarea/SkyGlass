//
//  SearchResultRow.swift
//  SkyGlass
//

import SwiftUI

struct SearchResultRow: View {
    let location: SearchLocationEntity
    @EnvironmentObject private var themeManager: ThemeManager
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(themeManager.currentTheme.primaryTextColor.opacity(0.7))

                VStack(alignment: .leading, spacing: 3) {
                    Text(location.name)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(themeManager.currentTheme.primaryTextColor)

                    Text(locationSubtitle)
                        .font(.caption)
                        .foregroundColor(themeManager.currentTheme.primaryTextColor.opacity(0.55))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(themeManager.currentTheme.primaryTextColor.opacity(0.35))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .glassStyle(cornerRadius: 18,  opacity: 0.45)
        }
        .buttonStyle(.plain)
    }

    private var locationSubtitle: String {
        [location.region, location.country]
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
    }
}
