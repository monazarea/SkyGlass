import Foundation

final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [String] = []

    init() {
        // initial setup
    }

    func performSearch() {
        // placeholder search logic
        results = query.isEmpty ? [] : ["Result for \(query) 1", "Result for \(query) 2"]
    }
}
