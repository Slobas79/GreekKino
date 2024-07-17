//
//  RoundView.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 17.7.24..
//

import SwiftUI

private enum Subview {
    case coupon
    case liveDrawing
    case results
}

struct RoundView: View {
    var viewModel: RoundViewModel
    
    @State private var selectedSubview: Subview = .coupon
    
    var body: some View {
        VStack {
            HStack {
                headerButton(subview: .coupon)
                headerButton(subview: .liveDrawing)
                    .frame(maxWidth: .infinity, alignment: .center)
                headerButton(subview: .results)
            }
            .padding()
            
            if nil == viewModel.roundInfo {
                SpinnerView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .center)
            } else {
                switch selectedSubview {
                case .coupon:
                    CouponView(viewModel: viewModel)
                case .liveDrawing:
                    LiveDrawingView()
                case .results:
                    HStack{}
                }
                
            }
        }
        .background(.primaryBackground)
        .onAppear {
            guard nil == viewModel.roundInfo else { return }
            Task { @MainActor in
                await viewModel.fetchRound()
            }
        }
    }
    
    @ViewBuilder
    private func headerButton(subview: Subview) -> some View {
        Button {
            if selectedSubview != subview {
                selectedSubview = subview
            }
        } label: {
            VStack {
                subview.image
                    .font(.largeTitle)
                Text(subview.title)
                    .font(.headline)
            }
            .tint(selectedSubview != subview ? .buttonTint : .selectedButtonTint)
        }
    }
}

extension Subview {
    var image: Image {
        switch self {
        case .coupon:
            return Image(systemName: "rectangle.grid.2x2")
        case.liveDrawing:
            return Image(systemName: "play.circle")
        case .results:
            return Image(systemName: "r.circle")
        }
    }
    
    var title: String {
        switch self {
        case .coupon:
            return "Talon"
        case .liveDrawing:
            return "Izvlacenje"
        case .results:
            return "Rezultati"
        }
    }
}

#Preview {
    RoundView(viewModel: RoundViewModel(roundId: 0, fetchUseCase: FetchRoundUseCaseMock(), countDownUseCase: CountDownUseCaseImpl()))
}
