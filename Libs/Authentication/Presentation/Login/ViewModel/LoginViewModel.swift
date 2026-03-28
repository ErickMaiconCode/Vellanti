import Foundation
import Combine

enum Field {
    case email, password
}

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let authState = AuthState.shared
    private let onSuccess: () -> Void
    private let onBackToGateway: () -> Void
    
    init(onSuccess: @escaping () -> Void, onBackToGateway: @escaping () -> Void) {
        self.onSuccess = onSuccess
        self.onBackToGateway = onBackToGateway
    }
    
    var isFormValid: Bool {
        !email.isEmpty &&
        email.contains("@") &&
        !password.isEmpty &&
        password.count >= 8
    }
    
    func login() async {
        guard isFormValid else {
            errorMessage = "Por favor, preencha todos os campos corretamente."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            try await authState.login(email: email, password: password)
            onSuccess()
        } catch let error as AuthError {
            errorMessage = error.toErrorType().message
        } catch {
            errorMessage = "Erro ao fazer login. Tente novamente"
        }
        
        isLoading = false
    }
    
    func forgotPassword() {}
    
    func backToGateway() {
        onBackToGateway()
    }
    
}
