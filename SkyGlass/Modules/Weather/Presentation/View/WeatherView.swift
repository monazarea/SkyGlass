import SwiftUI
 
struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    @EnvironmentObject private var themeManager: ThemeManager
    
    init(viewModel: WeatherViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }
    
    
    var body: some View {
        ZStack() {
            Image(viewModel.currentTheme.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .transition(.opacity)
 
            themeManager.currentTheme.backgroundOverlay
                .ignoresSafeArea()
 
            if viewModel.isLoading && viewModel.weather == nil {
                ProgressView("Fetching Weather...")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
 
            } else if let weather = viewModel.weather {
                VStack(spacing: 0) {
                    HeaderView(cityName: weather.cityName)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 24)
 
                    ScrollView(showsIndicators: false) {
                        CurrentWeatherSection(
                            weather: weather
                        )
 
                        if let todayForecast = weather.forecast.first {
                            HourlyForecastSection(
                                hours: todayForecast.hours
                            )
                            .padding(.top, 10)
                        }
 
                        DailyForecastSection(
                            days: weather.forecast
                        )
                        .padding(.top, 10)
 
                        WeatherMetricsGrid(
                            weather: weather,
                            hourlyForecast: weather.forecast.first?.hours ?? []
                        )
                        .padding(.top, 20)
                        .padding(.bottom, 90)
                    }
                    .padding(.horizontal, 10)
                }
                .padding(.horizontal, 20)
                .foregroundColor(themeManager.currentTheme.primaryTextColor)
            }
 
            if viewModel.weather != nil {
                FavoriteButton(
                    isFavorite: viewModel.isFavorite
                ) {
                    viewModel.toggleFavorite()
                }
                .padding(.trailing, 30)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }
        .animation(.easeInOut(duration: 1.0), value: themeManager.currentTheme)
        .onAppear {
            viewModel.onAppear()
        }.onChange(of: viewModel.currentTheme) { oldTheme, newTheme in
            themeManager.currentTheme = newTheme
        }.withGenericError(errorMessage: $viewModel.errorMessage)
    }
}
