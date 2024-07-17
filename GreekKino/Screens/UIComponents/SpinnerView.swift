//
//  SpinnerView.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import SwiftUI

struct SpinnerView: View {
  var body: some View {
    ProgressView()
      .scaleEffect(3.0, anchor: .center)
  }
}

#Preview {
    SpinnerView()
}
