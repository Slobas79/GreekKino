//
//  GreekKinoApp.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import SwiftUI

@main
struct GreekKinoApp: App {
    private var navigation: Navigation = Navigation(viewFactory: ViewFactory(diContainer: DependencyInjectionContainer()))
    
    var body: some Scene {
        WindowGroup {
            navigation.getRoot()
        }.environmentObject(navigation)
    }
}
