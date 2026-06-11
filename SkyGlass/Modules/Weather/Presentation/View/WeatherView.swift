import SwiftUI
 
struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
 
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // MARK: Background
            Image(viewModel.currentTheme.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .transition(.opacity)
 
            viewModel.currentTheme.backgroundOverlay
                .ignoresSafeArea()
 
            if viewModel.isLoading && viewModel.weather == nil {
                ProgressView("Fetching Weather...")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
 
            } else if let weather = viewModel.weather {
                VStack(spacing: 0) {
                    HeaderView(cityName: weather.cityName, theme: viewModel.currentTheme)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 24)
 
                    ScrollView(showsIndicators: false) {
                        CurrentWeatherSection(
                            weather: weather,
                            theme: viewModel.currentTheme
                        )
 
                        if let todayForecast = weather.forecast.first {
                            HourlyForecastSection(
                                hours: todayForecast.hours,
                                theme: viewModel.currentTheme
                            )
                            .padding(.top, 10)
                        }
 
                        DailyForecastSection(
                            days: weather.forecast,
                            theme: viewModel.currentTheme
                        )
                        .padding(.top, 10)
 
                        WeatherMetricsGrid(
                            weather: weather,
                            hourlyForecast: weather.forecast.first?.hours ?? [],
                            theme: viewModel.currentTheme
                        )
                        .padding(.top, 10)
                        .padding(.bottom, 90)
                    }
                    .padding(.horizontal, 10)
                }
                .padding(.horizontal, 20)
 
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
 
            if viewModel.weather != nil {
                FavoriteButton(
                    isFavorite: viewModel.isFavorite,
                    theme: viewModel.currentTheme
                ) {
                    viewModel.toggleFavorite()
                }
                .padding(.leading, 30)
                .padding(.bottom, 30)
            }
        }
        .animation(.easeInOut(duration: 1.0), value: viewModel.currentTheme)
        .onAppear {
            viewModel.onAppear()
        }
    }
}
