import Foundation

final class HomeViewModel: ObservableObject {
    @Published var items: [String] = []

    init() {
        load()
    }

    func load() {
        // Example placeholder data
        items = ["Home Item 1", "Home Item 2", "Home Item 3"]
    }
}
