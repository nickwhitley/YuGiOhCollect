//
//  CardModel.swift
//  YugiohCollect
//
//  Created by nwhitley.vendor on 6/3/24.
//
import Foundation
import SwiftData

@Model
final class Card: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let type: String
    
    init(id: Int,
         name: String,
         type: String) {
        self.id = id
        self.name = name
        self.type = type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
    }
    
}
