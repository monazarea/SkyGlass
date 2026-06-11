//
//  HeaderView.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//

import SwiftUI

struct HeaderView: View {
    let cityName: String
    @EnvironmentObject var appRouter: AppRouter
    let theme : AppTheme
    var body: some View {
        HStack {
            Button(action: { appRouter.navigate(to: .favorites)}) {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
            }
            
            Spacer()
            
            Text(cityName)
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Button(action: {appRouter.navigate(to: .search) }) {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
            }
        }
        .foregroundColor(theme.primaryTextColor)
    }
}

