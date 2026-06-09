import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel

    init(viewModel: SearchViewModel = SearchViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $viewModel.query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List(viewModel.results, id: \ .self) { item in
                    Text(item)
                }
            }
            .navigationTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
