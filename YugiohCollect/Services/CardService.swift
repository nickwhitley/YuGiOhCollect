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
            guard let cardCount = try await getAllCards()?.count else { return 0 }
            return cardCount
        } catch {
            
        }
        return 1
    }
    
    public func getAllCards() async throws -> [Card]? {
        let url = URL(string: "https://db.ygoprodeck.com/api/v7/cardinfo.php")!
        let (data, _) = try await URLSession.shared.data(from: url)
        //let cards = try JSONDecoder().decode(Cards.self, from: data).data
        
        let decoder = JSONDecoder()
        do {
            let cardData = try decoder.decode(CardData.self, from: data)
            return cardData.data
        } catch {
            print("Failed to decode JSON: \(error)")
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
