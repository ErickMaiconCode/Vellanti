import Foundation

final class BoutiqueAPIService {
    static let shared = BoutiqueAPIService()
    private let baseURL = "https://69c29ff47518bf8facbefd16.mockapi.io/api/clothes/clothes"
    
    func fetchClothingItems() async throws -> [ClothingItem] {
        guard let url = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        let items: [ClothingItem] = try await NetworkService.shared.fetch(from: url)
        return items
    }
}
