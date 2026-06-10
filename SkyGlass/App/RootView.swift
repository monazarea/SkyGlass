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
                HomeView(viewModel: container.makeWeatherViewModel())
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .home:
                            HomeView(viewModel: container.makeWeatherViewModel())
                        case .search:
                            SearchView()
                        case .favorites:
                            FavoriteView()
                        }
                    }
            }
        }
    }


