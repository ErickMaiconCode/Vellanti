import Foundation
import FirebaseAuth

enum AuthError: Error {
    case invalidEmail
    case weakPassword
    case emailAlreadyInUse
    case userNotFound
    case wrongPassword
    case invalidCredential
    case networkError
    case unknown(String)
    
    func toErrorType() -> ErrorType {
        switch self {
        case .invalidEmail:
            return .authInvalidEmail
        case .weakPassword:
            return .authWeakPassword
        case .emailAlreadyInUse:
            return .authEmailInUse
        case .userNotFound:
            return .authUserNotFound
        case .wrongPassword, .invalidCredential:
            return .authWrongPassword
        case .networkError:
            return .noConnection
        case .unknown(_):
            return .authGeneric("Esta conta foi desativada. Entre em contato com o suporte.")
        }
    }
    
    static func from(firebaseError: NSError) -> AuthError {
        guard let errorCode = AuthErrorCode(_bridgedNSError: firebaseError) else {
            return .unknown(firebaseError.localizedDescription)
        }
        
        switch errorCode {
        case .invalidEmail:
            return .invalidEmail
        case .weakPassword:
            return .weakPassword
        case .emailAlreadyInUse:
            return .emailAlreadyInUse
        case .userNotFound:
            return .userNotFound
        case .wrongPassword:
            return .wrongPassword
        case .invalidCredential:
            return .invalidCredential
        case .networkError:
            return .networkError
        default:
            return .unknown("Erro ao autenticar. Tente novamente.")
        }
    }
}
