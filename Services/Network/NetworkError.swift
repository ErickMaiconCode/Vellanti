import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case noConnection
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL Inválida"
        case .noData:
            return "Nenhum dado recebido"
        case .decodingError:
            return "Erro ao processar dados"
        case .serverError(let code):
            return "Erro de servidor (\(code)"
        case .noConnection:
            return "Sem conexão com a internet"
        }
    }
    
    var icon: String {
        switch self {
        case .invalidURL, .decodingError:
            return "exclamationmark.triangle"
        case .noData:
            return "tray"
        case .serverError:
            return "server.rack"
        case .noConnection:
            return "wifi.slash"
        }
    }
}
