import Foundation

final class FavoriteViewModel: ObservableObject {
    @Published var favorites: [String] = []

    init() {
        loadFavorites()
    }

    func loadFavorites() {
        // placeholder favorites
        favorites = ["Favorite 1", "Favorite 2"]
    }

    func add(_ item: String) {
        favorites.append(item)
    }
}
