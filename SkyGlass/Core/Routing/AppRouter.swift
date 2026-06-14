//
//  AppRouter.swift
//  SkyGlass
//
//  Created by Mona Zarea on 08/06/2026.
//

import SwiftUI
enum Route : Hashable{
    case home
    case search
    case favorites
    case fullForecast(days: [DayEntity])
    
}

final class AppRouter : ObservableObject {
    @Published  var path = NavigationPath()
    
    func navigate(to router : Route){
        path.append(router)
    }
    func goBack(){
        if !path.isEmpty{
            path.removeLast()
        }
    }
    
    func popToRoot(){
        path.removeLast(path.count)
    }
}
