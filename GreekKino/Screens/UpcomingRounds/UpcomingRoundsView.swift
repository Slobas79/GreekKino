//
//  UpcomingRoundsView.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import SwiftUI

struct UpcomingRoundsView: View {
    var viewModel: UpcomingRoundsViewModel
    
    @EnvironmentObject var navigation: Navigation
    
    var body: some View {
        NavigationStack(path: $navigation.navPath) {
            VStack(alignment: .leading) {
                Text(Strings.title)
                    .font(.title)
                    .padding(Const.titlePadding)
                
                if viewModel.upcomingRoundItems.isEmpty {
                    SpinnerView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .center)
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0.0, pinnedViews: [.sectionHeaders]) {
                            Section {
                                ForEach(viewModel.upcomingRoundItems, id: \.id) { item in
                                    listItem(model: item)
                                        .onTapGesture {
                                            navigation.navigate(to: .round(id: item.id))
                                        }
                                }
                            } header: {
                                listHeader()
                            }
                        }
                    }
                }
            }
            .background(.primaryBackground)
            .navigationDestination(for: Screen.self) { screen in
                navigation.viewFor(screen: screen)
            }
            .onAppear(perform: {
                guard viewModel.upcomingRoundItems.isEmpty else { return }
                Task { @MainActor in
                    await viewModel.fetch()
                }
            })
        }
        .tint(.buttonTint)
    }
}

extension UpcomingRoundsView {
    @ViewBuilder
    private func listItem(model: UpcomingRoundItem) -> some View {
        VStack(spacing: 0.0) {
            HStack {
                Text(model.timeString)
                    .foregroundStyle(.primary)
                Spacer()
                Text(model.countDownString)
                    .foregroundStyle(model.isRed ? .red : .primary)
            }
            .padding()
            .background(.secondaryBackground)
            Divider()
        }
    }
    
    @ViewBuilder
    private func listHeader() -> some View {
        VStack(spacing: 0.0) {
            Divider()
                .background(.gray)
            HStack {
                Text(Strings.vremeIzvlacenja)
                Spacer()
                Text(Strings.preostaloZaUplatu)
            }
            .font(.title3)
            .padding()
            .background(.primaryBackground)
        }
    }
}

private struct Const {
    static let titlePadding = EdgeInsets(top: 0.0, leading: 16.0, bottom: 8.0, trailing: 16.0)
}

private struct Strings {
    static let title = "GRCKI KINO (20/80)"
    static let vremeIzvlacenja = "Vreme izvlacenja"
    static let preostaloZaUplatu = "Preostalo za uplatu"
}

#Preview {
    UpcomingRoundsView(viewModel: UpcomingRoundsViewModel(fetchUseCase: FetchUpcomingRoundsUseCaseMock(), countDownController: CountDownControllerImpl()))
}

