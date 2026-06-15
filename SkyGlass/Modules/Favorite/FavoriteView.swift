//
//  FavoritesView.swift
//  SkyGlass
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var viewModel: FavoritesViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Image(themeManager.currentTheme.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            themeManager.currentTheme.backgroundOverlay
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Text("FAVORITES")
                        .font(.caption)
                        .fontWeight(.bold)
                        .tracking(1.5)
                        .foregroundColor(themeManager.currentTheme.primaryTextColor.opacity(0.6))

                    Spacer()

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(themeManager.currentTheme.primaryTextColor.opacity(0.6))
                            .padding(10)
                            .glassStyle(cornerRadius: 12, opacity: 0.4)
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
                            .foregroundColor(themeManager.currentTheme.primaryTextColor.opacity(0.4))
                        
                        Text("No saved locations yet.\nSearch for a city to add it here.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(themeManager.currentTheme.primaryTextColor.opacity(0.5))
                        Spacer()
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.favorites) { location in
                                FavoriteRow(
                                    location: location,
                                    onSelect: {
                                        viewModel.selectFavorite(location)
                                        dismiss()
                                    },
                                    onDelete: {
                                        withAnimation {
                                            viewModel.removeFavorite(id: location.id)
                                        }
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 20) 
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    }
                }
            }.padding(10)
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.loadFavorites()
        }
    }

    
}

struct FavoriteRow: View {
    let location: FavoriteLocation
    let onSelect: () -> Void
    let onDelete: () -> Void
    @State private var showingDeleteAlert = false
    var body: some View {
        HStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(location.cityName)
                        .font(.headline)
                    
                    Text(location.country)
                        .font(.subheadline)
                }
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                onSelect()
            }
            
            Button {
                showingDeleteAlert = true
            } label: {
                Image(systemName: "trash.fill")
                    .foregroundColor(.gray.opacity(0.8))
                    .font(.system(size: 18))
                    .padding(.leading, 12)
                    .padding(.vertical, 8)
            }
        }
        .padding(16)
        .glassStyle(cornerRadius: 16, opacity: 0.3)
        .alert("Remove Location", isPresented: $showingDeleteAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Delete", role: .destructive) {
                        onDelete() 
                    }
                } message: {
                    Text("Are you sure you want to remove \(location.cityName) from your favorites?")
                }
    }
}
