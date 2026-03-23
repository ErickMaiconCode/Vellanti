import Foundation

final class BoutiqueAPIService {
    static let shared = BoutiqueAPIService()
    private let baseURL = "https://69b07034c63dd197febc4844.mockapi.io/agidevs/clothes"
    
    func fetchClothingItems() async throws -> [ClothingItem] {
        guard let url = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        let items: [ClothingItem] = try await NetworkService.shared.fetch(from: url)
        return items
    }
}
