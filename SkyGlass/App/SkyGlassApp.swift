//
//  SkyGlassApp.swift
//  SkyGlass
//
//  Created by Mona Zarea on 08/06/2026.
//

import SwiftUI
import SwiftData

@main
struct SkyGlassApp: App {
    let appContainer: AppContainer
    @MainActor
        init() {
            self.appContainer = AppContainer()
        }
    var body: some Scene {
        WindowGroup {
            RootView(container: appContainer)
        }.modelContainer(appContainer.modelContainer)
    }
}
