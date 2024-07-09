//
//  CardView.swift
//  YugiohCollect
//
//  Created by nwhitley.vendor on 6/8/24.
//

import SwiftUI
import SwiftData

struct CardView: View {
    @Bindable var card: Card
    
    var body: some View {
        VStack {
            FullCardImageView(cardId: card.id)
                .padding(10)
            Text(card.name)
            Text(card.type)
        }
    }
}

struct FullCardImageView: View {
    var cardId: Int
    var body: some View {
        AsyncImage(url: URL(string: "https://images.ygoprodeck.com/images/cards/\(cardId).jpg")) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
        } placeholder: {
            Image("SmallCardPlaceholder") // Use the name of the image asset
                            .resizable()
                            .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Card.self, configurations: config)
        let card = Card(id: 28596933, name: "A Wingbeat of Giant Dragon", type: "Spell Card")
        
        return CardView(card: card)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container")
    }
}
