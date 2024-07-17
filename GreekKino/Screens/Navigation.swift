//
//  Navigation.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation
import SwiftUI

enum Screen: Hashable {
    case upcomingRounds
    case round(id: UInt)
}

final class Navigation: ObservableObject {
    private let viewFactory: ViewFactory
    
    @Published var navPath = NavigationPath()
    
    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }
    
    func getRoot() -> some View {
        return viewFactory.createUpcomingRoundsScreen()
    }
    
    @ViewBuilder
    func viewFor(screen: Screen) -> some View {
        switch screen {
        case.upcomingRounds:
            viewFactory.createUpcomingRoundsScreen()
        case .round(let id):
            viewFactory.createRoundScreen(roundId: id)
        }
    }
    
    func navigate(to screen: Screen) {
        navPath.append(screen)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
