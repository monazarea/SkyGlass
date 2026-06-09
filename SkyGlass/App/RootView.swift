//
//  RootView.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = RootViewModel()
    @StateObject private var appRouter = AppRouter()
    
    var body: some View {
        Group{
            switch viewModel.currentState {
            case .splash:
                SplashView()
            case .ready:
                MainContentView()
                    .environmentObject(appRouter)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.currentState)
        
        
    }
}
    struct MainContentView: View {
        @EnvironmentObject var appRouter: AppRouter
        
        var body: some View {
            NavigationStack(path: $appRouter.path) {
                HomeView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .home:
                            HomeView()
                        case .search:
                            SearchView()
                        case .favorites:
                            FavoriteView()
                        }
                    }
            }
        }
    }


