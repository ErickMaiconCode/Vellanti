import Foundation
import SwiftUI

enum ErrorType {
        case noConnection
        case serverError
        case notFound
        case emptyData(String)
        case generic(String)
        
        var title: String {
            switch self {
            case .noConnection:
                return "Sem Conexão"
            case .serverError:
                return "Erro no Servidor"
            case .notFound:
                return "Não Encontrado"
            case .emptyData:
                return "Nada por aqui"
            case .generic:
                return "Ops!"
            }
        }
        
        var message: String {
            switch self {
            case .noConnection:
                return "Verifique sua conexão com a internet e tente novamente"
            case .serverError:
                return "Nossos servidores estão temporariamente indisponíveis"
            case .notFound:
                return "O conteúdo que você procura não existe"
            case .emptyData(let customMessage):
                return customMessage
            case .generic(let customMessage):
                return customMessage
            }
        }
        
        var icon: String {
            switch self {
            case .noConnection:
                return "wifi.slash"
            case .serverError:
                return "server.rack"
            case .notFound:
                return "magnifyingglass"
            case .emptyData:
                return "tray"
            case .generic:
                return "exclamationmark.triangle"
            }
        }
        
        var iconColor: Color {
            switch self {
            case .emptyData:
                return .gray
            default:
                return .red
            }
        }
    }

extension ErrorType {
    init(from networkError: NetworkError) {
        switch networkError {
        case .noConnection:
            self = .noConnection
        case .serverError:
            self = .serverError
        case .invalidURL, .decodingError:
            self = .generic("Erro ao processar dados")
        case .noData:
            self = .emptyData("Nenhum dado disponível")
        }
    }
}
