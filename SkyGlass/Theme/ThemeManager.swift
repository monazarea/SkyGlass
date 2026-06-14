//
//  ThemeManager.swift
//  SkyGlass
//
//  Created by Mona Zarea on 13/06/2026.
//

import Foundation
import SwiftUI

@MainActor
class ThemeManager : ObservableObject{
    @Published var currentTheme: AppTheme = .sunny
}
