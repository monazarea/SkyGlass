//
//  FavoritesView.swift
//  SkyGlass
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var viewModel: FavoritesViewModel
    @Environment(\.appTheme) private var theme
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // MARK: Background
            Image(theme.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            theme.backgroundOverlay
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Text("FAVORITES")
                        .font(.caption)
                        .fontWeight(.bold)
                        .tracking(1.5)
                        .foregroundColor(theme.primaryTextColor.opacity(0.6))

                    Spacer()

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(theme.primaryTextColor.opacity(0.6))
                            .padding(10)
                            .glassStyle(cornerRadius: 12, theme: theme, opacity: 0.4)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 16)

                if viewModel.favorites.isEmpty {
                    VStack(spacing: 14) {
                        Spacer()
                        Image(systemName: "heart.slash")
                            .font(.system(size: 36, weight: .thin))
                            .foregroundColor(theme.primaryTextColor.opacity(0.4))
                        
                        Text("No saved locations yet.\nSearch for a city to add it here.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(theme.primaryTextColor.opacity(0.5))
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(viewModel.favorites) { location in
                            Button {
                                viewModel.selectFavorite(location)
                                dismiss()
                            } label: {
                                FavoriteRow(location: location, theme: theme)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteFavorite)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.loadFavorites()
        }
    }

    private func deleteFavorite(at offsets: IndexSet) {
        for index in offsets {
            let location = viewModel.favorites[index]
            viewModel.removeFavorite(id: location.id)
        }
    }
}

struct FavoriteRow: View {
    let location: FavoriteLocation
    let theme: AppTheme
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(location.cityName)
                    .font(.headline)
                    .foregroundColor(theme.primaryTextColor)
                
                Text(location.country)
                    .font(.subheadline)
                    .foregroundColor(theme.primaryTextColor.opacity(0.6))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(theme.primaryTextColor.opacity(0.4))
                .font(.system(size: 14, weight: .bold))
        }
        .padding(16)
        .glassStyle(cornerRadius: 16, theme: theme, opacity: 0.3)
        .padding(.vertical, 4)
    }
}
