//
//  ResultsView.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 18.7.24..
//

import SwiftUI

struct ResultsView: View {
    var results: [ResultItem]
    
    private let columns = [
        GridItem(.adaptive(minimum: Const.cellW))
    ]
    
    var body: some View {
        ScrollView {
            ForEach(results, id: \.self) { result in
                resultItemView(result)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func resultItemView(_ item: ResultItem) -> some View {
        VStack {
            Text("\(Strings.vremeIzvlacenja): \(item.timeString) | \(Strings.kolo): \(item.id.toString())")
                .frame(maxWidth: .infinity, alignment: .leading)
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(item.numbers, id: \.self) { number in
                    numberCell(number)
                }
            }
            Divider()
        }
    }
    
    @ViewBuilder
    private func numberCell(_ number: Int) -> some View {
        VStack {
            Text("\(number)")
                .font(.title)
                .frame(width: Const.cellW, height: Const.cellH)
        }
        .border(number.resultColor, width: 4)
        
        .background(.secondaryBackground)
    }
}

private struct Const {
    static let cellW: CGFloat = 60.0
    static let cellH: CGFloat = 60.0
}

private struct Strings {
    static let vremeIzvlacenja = "Vreme izvlacenja"
    static let kolo = "Kolo"
}


#Preview {
    let result = Result(drawId: 0, drawTime: Date(), numbers: [11,2,31,48,56,64,73,80,19,10,21,32,13,67,55,43,77,18,3,20])
    return ResultsView(results: [ResultItem(model: result)])
}
