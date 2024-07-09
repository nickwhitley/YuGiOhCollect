//
//  CardsView.swift
//  YugiohCollect
//
//  Created by nwhitley.vendor on 6/12/24.
//

import SwiftUI
import SwiftData

struct CardListView: View {
    @Environment(\.modelContext) var modelContext
    @State var cards: [Card] = []
    let cardService = CardService()
    
    var body: some View {
        NavigationStack {
            VStack {
            Spacer()
            ScrollView {
                    LazyVStack {
                        ForEach(cards) { card in
                            NavigationLink(value: card) {
                                CardListComponent(cardId: String(card.id),cardName: card.name, cardType: card.type)
                            }
                            .navigationDestination(for: Card.self) { card in
                                    CardView(card: card)
                            }
                        }
                    }
                }
            }
        }
        .task {
            await loadCards()
        }
    }
        
    private func loadCards() async {
        do {
            if let fetchedCards = try await cardService.getAllCards() {
                DispatchQueue.main.async {
                    self.cards = fetchedCards
                }
            }
        } catch {
            print("Error fetching cards")
        }
    }
}

#Preview {
    CardListView()
        .modelContainer(for: Card.self)
}
