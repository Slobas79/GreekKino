//
//  FontSizeBoundaryModifier.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 18.7.24..
//

import SwiftUI

struct FontSizeBoundaryModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .dynamicTypeSize(.medium ... .xxLarge)
    }
}
