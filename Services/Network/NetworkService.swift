import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    func fetch<T: Decodable>(from url: URL) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.serverError(0)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.serverError(httpResponse.statusCode)
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError
            }
            
            catch let error as NetworkError {
                throw error
            } catch {
                throw NetworkError.noConnection
            }
        }
    }
}
