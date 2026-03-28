import Foundation
import FirebaseAuth

enum AuthError: Error {
    case invalidEmail
    case weakPassword
    case emailAlreadyInUse
    case useNotFound
    case wrongPassword
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
        case .useNotFound:
            return .authUserNotFound
        case .wrongPassword:
            return .authWrongPassword
        case .networkError:
            return .noConnection
        case .unknown(let message):
            return .authGeneric(message)
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
            return .useNotFound
        case .wrongPassword:
            return .wrongPassword
        case .networkError:
            return .networkError
        default:
            return .unknown(firebaseError.localizedDescription)
        }
    }
}
