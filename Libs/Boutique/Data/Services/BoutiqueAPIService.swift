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
    
    func createProduct(_ product: ClothingItem) async throws {
        guard let url = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        request.httpBody = try encoder.encode(product)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError(0)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(0)
        }
    }
}
