//
//  RootViewModel.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation
import SwiftUI
enum AppState{
    case splash
    case ready
}
@MainActor
class RootViewModel : ObservableObject{
    @Published var currentState : AppState = .splash
    
    init(){
        initializeApp()
    }
    
    private func initializeApp(){
        
        Task{
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            
                self.currentState = .ready
                
            
        }
    }
}
