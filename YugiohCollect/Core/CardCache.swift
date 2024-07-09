import Foundation

class CardCache {
    static let shared = CardCache()
    private var cards: [Card]?
    private let cacheExpirationInterval: TimeInterval = 3600 // 1 hour

        private init() {}
        
        private var lastUpdated: Date?

        func getCards() -> [Card]? {
            guard let lastUpdated = lastUpdated else { return nil }
            if Date().timeIntervalSince(lastUpdated) > cacheExpirationInterval {
                // Cache is expired
                cards = nil
                return nil
            }
            return cards
        }
        
        func saveCards(_ cards: [Card]) {
            self.cards = cards
            lastUpdated = Date()
        }
        
        func clearCache() {
            cards = nil
            lastUpdated = nil
        }
    
}
