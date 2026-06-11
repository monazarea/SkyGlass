//
//  RootView.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import SwiftUI

struct RootView: View {
    let container: AppContainer
    @StateObject private var viewModel = RootViewModel()
    @StateObject private var appRouter = AppRouter()
    
    var body: some View {
        Group{
            switch viewModel.currentState {
            case .splash:
                SplashView()
            case .ready:
                MainContentView(container: container)
                    .environmentObject(appRouter)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.currentState)
        
        
    }
}
    struct MainContentView: View {
        let container: AppContainer
        @EnvironmentObject var appRouter: AppRouter
        
        var body: some View {
            NavigationStack(path: $appRouter.path) {
                WeatherView(viewModel: container.makeWeatherViewModel())
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .home:
                            WeatherView(viewModel: container.makeWeatherViewModel())
                        case .search:
                            SearchView(viewModel: container.makeSearchViewModel())
                        case .favorites:
                            FavoriteView(viewModel: container.makeFavoritesViewModel())
                        case .fullForecast(let days, let theme):
                            FullDailyForecastView(days: days, theme: theme)
                                            
                        }
                        
                    }
            }.environment(\.appTheme, container.makeWeatherViewModel().currentTheme)
        }
    }


