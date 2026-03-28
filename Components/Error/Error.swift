import Foundation
import SwiftUI

enum ErrorType {
        case noConnection
        case serverError
        case notFound
        case emptyData(String)
        case generic(String)
    
        case authInvalidEmail
        case authWeakPassword
        case authEmailInUse
        case authUserNotFound
        case authWrongPassword
        case authGeneric(String)
        
        var title: String {
            switch self {
            case .noConnection:
                return "Conexão interrompida"
            case .serverError:
                return "Serviço indisponível"
            case .notFound:
                return "Item não localizado"
            case .emptyData:
                return "Nenhum item"
            case .generic:
                return "Atenção"
                
            case .authInvalidEmail:
                return "E-mail inválido"
            case .authWeakPassword:
                return "Senha fraca"
            case .authEmailInUse:
                return "E-mail em uso"
            case .authUserNotFound:
                return "Usuário não encontrado"
            case .authWrongPassword:
                return "Senha incorreta"
            case .authGeneric:
                return "Erro de autenticação"
            }
        }
        
        var message: String {
            switch self {
            case .noConnection:
                return "Não foi possível sincronizar com a boutique. Verifique sua conexão e tente novamente."
            case .serverError:
                return "Estamos aprimorando nossos serviços. Por favor, retorne em instantes."
            case .notFound:
                return "O item que você procura não está mais disponível em nosso acervo."
            case .emptyData(let customMessage):
                return customMessage
            case .generic(let customMessage):
                return customMessage
                
            case .authInvalidEmail:
                return "O e-mail informado não é válido. Por favor, verifique e tente novamente."
            case .authWeakPassword:
                return "A senha deve conter no mínimo 8 caracteres, incluindo maiúsculas, minúsculas, números e caracteres especiais."
            case .authEmailInUse:
                return "Este e-mail já está cadastrado. Faça login ou recupere sua senha."
            case .authUserNotFound:
                return "Não encontramos uma conta com este e-mail. Verifique os dados ou crie uma nova conta."
            case .authWrongPassword:
                return "A senha informada está incorreta. Tente novamente ou recupere sua senha."
            case .authGeneric(let customMessage):
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
                
            case .authInvalidEmail:
                return "envelope.badge.fill"
            case .authWeakPassword:
                return "lock.shield"
            case .authEmailInUse:
                return "person.crop.circle.badge.exclamationmark"
            case .authUserNotFound:
                return "person.crop.circle.badge.questionmark"
            case .authWrongPassword:
                return "key.slash"
            case .authGeneric:
                return "exclamationmark.shield"
            }
        }
        
        var iconColor: Color {
            switch self {
            case .noConnection, .generic, .serverError:
                return .black.opacity(0.8)
            default:
                return .gray
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
