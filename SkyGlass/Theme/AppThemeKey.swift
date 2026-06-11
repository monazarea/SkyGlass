//
//  EnvironmentKey.swift
//  SkyGlass
//
//  Created by Mona Zarea on 11/06/2026.
//
import SwiftUI

struct AppThemeKey: EnvironmentKey {
    static let defaultValue: AppTheme = .sunny
}

extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}
