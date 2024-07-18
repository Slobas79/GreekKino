//
//  CouponView.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 17.7.24..
//

import SwiftUI

struct CouponView: View {
    private let maxNumbers = 80
    private let maxNumbersToSelect = 12
    private let columns = [
        GridItem(.adaptive(minimum: Const.cellW))
    ]
    
    @Bindable var viewModel: RoundViewModel
    
    var body: some View {
        VStack{
            roundInfoView()
            Divider()
            HStack {
                Text("Izabrano je \(viewModel.selectedNumbers.count) kuglice")
                Spacer()
            }
            Divider()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(1...maxNumbers, id: \.self) { number in
                        cellButton(number)
                    }
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func roundInfoView() -> some View {
        HStack(spacing: 0) {
            VStack {
                Text(Strings.vremeIzvlacenja)
                    .lineLimit(1)
                    .allowsTightening(true)
                Text("\(viewModel.roundInfo?.timeString ?? "")")
            }
            
            VStack {
                Text(Strings.kolo)
                Text("\(viewModel.roundInfo?.id.toString() ?? "")")
            }
            .frame(maxWidth: 80)
            
            VStack {
                Text(Strings.preostaloZaUplatu)
                    .lineLimit(1)
                    .allowsTightening(true)
                Text("\(viewModel.roundInfo?.countDownString ?? "")")
            }
        }
    }
    
    @ViewBuilder
    private func cellButton(_ number: Int) -> some View {
        VStack {
            Button {
                if !isSelected(number) {
                    select(number)
                } else {
                    remove(number)
                }
            } label: {
                Text("\(number)")
                    .font(isSelected(number) ? .largeTitle : .title)
                    .frame(width: Const.cellW, height: Const.cellH)
            }
            .tint(.buttonTint)
        }
        .border(isSelected(number) ? .buttonTint : .secondaryBackground, width: 3)
        
        .background(.secondaryBackground)
    }
    
    private func isSelected(_ number: Int) -> Bool {
        return viewModel.selectedNumbers.contains(where: {$0 == number})
    }
    
    private func remove(_ number: Int) {
        if let index = viewModel.selectedNumbers.firstIndex(of: number) {
            viewModel.selectedNumbers.remove(at: index)
        }
    }
    
    private func select(_ number: Int) {
        guard viewModel.selectedNumbers.count < maxNumbersToSelect else { return }
        viewModel.selectedNumbers.append(number)
    }
}

private struct Strings {
    static let vremeIzvlacenja = "Vreme izvlacenja"
    static let preostaloZaUplatu = "Preostalo za uplatu"
    static let kolo = "Kolo"
}

private struct Const {
    static let cellW: CGFloat = 60.0
    static let cellH: CGFloat = 60.0
}

#Preview {
    CouponView(viewModel: RoundViewModel(roundId: 0, fetchUseCase: FetchRoundUseCaseMock(), countDownController: CountDownControllerImpl(), fetchResultsUseCase: FetchResultsUseCaseMock()))
}
