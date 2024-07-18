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
                headerButton(subview: .results, action: {
                    Task { @MainActor in
                        await viewModel.fetchResults()
                    }
                })
            }
            .padding()
            
            switch selectedSubview {
            case .coupon:
                if let round = viewModel.roundInfo {
                    CouponView(viewModel: viewModel)
                } else {
                    spinner()
                }
            case .liveDrawing:
                LiveDrawingView()
            case .results:
                if let results = viewModel.resultsInfo {
                    ResultsView(results: results)
                } else {
                    spinner()
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
    private func headerButton(subview: Subview, action: (() -> Void)? = nil) -> some View {
        Button {
            if selectedSubview != subview {
                selectedSubview = subview
            }
            action?()
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
    
    @ViewBuilder
    private func spinner() -> some View {
        SpinnerView()
            .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .center)
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
    RoundView(viewModel: RoundViewModel(roundId: 0, fetchUseCase: FetchRoundUseCaseMock(), countDownUseCase: CountDownUseCaseImpl(), fetchResultsUseCase: FetchResultsUseCaseMock()))
}
