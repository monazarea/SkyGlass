import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var themeManager: ThemeManager


    var body: some View {
        ZStack {
            // MARK: Background
            Image(themeManager.currentTheme.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            themeManager.currentTheme.backgroundOverlay
                .ignoresSafeArea()

            VStack(spacing: 0) {
                
                SearchBarView(
                    text: $viewModel.searchText,
                    onClear: viewModel.clearSearch
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 16)

                bodyContent
                    .animation(.easeInOut(duration: 0.25), value: viewModel.isLoading)
                    .animation(.easeInOut(duration: 0.25), value: viewModel.searchResults.count)
            }
        }
    }

    @ViewBuilder
    private var bodyContent: some View {
        if viewModel.isLoading {
            centeredState {
                ProgressView("Searching...")
                    .foregroundColor(themeManager.currentTheme.primaryTextColor)
            }
        } else if !viewModel.searchResults.isEmpty {
            resultsList
        } else if let error = viewModel.errorMessage {
            centeredState { emptyState(message: error) }
        } else if viewModel.searchText.isEmpty {
            centeredState {
                emptyState(icon: "magnifyingglass", message: "Type a city or location\nto get started.")
            }
        } else {
            centeredState {
                emptyState(icon: "ellipsis", message: "Keep typing...")
            }
        }
    }

    private var resultsList: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("RESULTS")
                        .font(.caption)
                        .fontWeight(.bold)
                        .tracking(1.5)

                    Spacer()

                    Image(systemName: "location.magnifyingglass")
                }
                .foregroundColor(themeManager.currentTheme.primaryTextColor.opacity(0.6))
                .padding(.horizontal, 10)
                .padding(.bottom, 4)

                ForEach(viewModel.searchResults) { location in
                    SearchResultRow(location: location) {
                        viewModel.selectLocation(location)
                        dismiss()
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }

    private func centeredState<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack {
            Spacer()
            content()
            Spacer()
        }
    }

    @ViewBuilder
    private func emptyState(icon: String = "mappin.slash", message: String) -> some View {
        VStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 36, weight: .thin))
                .foregroundColor(themeManager.currentTheme.primaryTextColor.opacity(0.4))

            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(themeManager.currentTheme.primaryTextColor.opacity(0.5))
        }
        .padding(.horizontal, 40)
    }
}
