import SwiftUI

struct FavoriteView: View {
    @StateObject var viewModel: FavoriteViewModel

    init(viewModel: FavoriteViewModel = FavoriteViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.favorites.isEmpty {
                    Text("No favorites yet")
                } else {
                    List(viewModel.favorites, id: \ .self) { fav in
                        Text(fav)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
