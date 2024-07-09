//
//  CardAPIService.swift
//  YugiohCollect
//
//  Created by nwhitley.vendor on 6/3/24.
//

import Foundation
import SwiftUI

struct CardService{
    public func GetCardsCount() async -> Int{
        do {
            let cards = try await fetchAllCards { fetchedCards in
                if let cards = fetchedCards {
                    print("Fetched cards")
                } else {
                    print("Failed to fetch cards")
                }
            }
            return cards?.count ?? 0
        } catch {
            print("Error when fetching cards")
        }
        return 0
    }
    
    public func fetchAllCards(completion: @escaping ([Card]?) -> Void) async throws -> [Card]? {
        if let cachedCards = CardCache.shared.getCards() {
            completion(cachedCards)
            return cachedCards
        }
        
        let url = URL(string: "https://db.ygoprodeck.com/api/v7/cardinfo.php")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let cardData = try decoder.decode(CardData.self, from: data)
            
            CardCache.shared.saveCards(cardData.data)
            completion(cardData.data)
            return cardData.data
        } catch {
            print("failed to fetch cards")
            completion(nil)
            return nil
        }
    }
    
    public func GetDemoCards() -> [Card] {
        var cards: [Card] = []
        cards.append(Card(id: 100, name: "\"A\" Cell Breeding Device", type: "Spell Card"))
        cards.append(Card(id: 28596933, name: "A Wingbeat of Giant Dragon", type: "Spell Card"))
        cards.append(Card(id: 13026402, name: "A-Team: Trap Disposal Unit", type: "Spell Card"))
        cards.append(Card(id: 1400, name: "\"A\" Cell Breeding Device", type: "Spell Card"))
        cards.append(Card(id: 1500, name: "\"A\" Cell Breeding Device", type: "Spell Card"))
        cards.append(Card(id: 1600, name: "\"A\" Cell Breeding Device", type: "Spell Card"))
        cards.append(Card(id: 1700, name: "\"A\" Cell Breeding Device", type: "Spell Card"))
        return cards
    }
    
    public func GetDemoCard() -> Card {
        return Card(id: 28596933, name: "A Wingbeat of Giant Dragon", type: "Spell Card")
    }
}


// Root model
struct CardData: Decodable {
    let data: [Card]
}
