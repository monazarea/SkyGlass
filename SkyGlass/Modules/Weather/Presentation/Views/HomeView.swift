import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: WeatherViewModel

    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Home")
                
                // Safely read the published `weather` from the view model and show a user-friendly summary
                if let weather = viewModel.weather {
                    Text("Current Weather: \(weather.cityName) — \(String(format: "%.1f", weather.tempC))°C")
                } else if viewModel.isLoading {
                    Text("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                } else {
                    Text("No weather data")
                }
            }
            .navigationTitle("Home")
            
            // 👇 السر كله في التلات سطور دول!
            .onAppear {
                viewModel.onAppear ()// إدينا إشارة البدء للـ ViewModel
            }
        }
    }
}
