import Foundation
import SwiftUI
import Combine

@MainActor
final class RegisterViewModel: ObservableObject {
    @Published var currentStep: RegisterStep = .authentication
    @Published var registerData = RegisterData()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let authState = AuthState.shared
    private let onSuccess: () -> Void
    private let onBackToGateway: () -> Void
    
    init(onSuccess: @escaping () -> Void, onBackToGateway: @escaping () -> Void) {
        self.onSuccess = onSuccess
        self.onBackToGateway = onBackToGateway
    }
    
    var progress: Double {
        Double(currentStep.rawValue + 1) / Double(RegisterStep.allCases.count)
    }
    
    var canProceed: Bool {
        switch currentStep {
        case .authentication:
            return isAuthenticationValid
        case .personalData:
            return isPersonalDataValid
        case .contact:
            return isContactValid
        }
    }
    
    private var isAuthenticationValid: Bool {
        !registerData.email.isEmpty &&
        registerData.email.contains("@") &&
        registerData.password.isValidPassword &&
        registerData.password == registerData.confirmPassword
    }
    
    private var isPersonalDataValid: Bool {
        !registerData.name.isEmpty &&
        !registerData.lastName.isEmpty
    }
    
    private var isContactValid: Bool {
        let digitsOnly = registerData.phone.filter { $0.isNumber }
        
        switch registerData.phoneCountryCode {
        case "+55":
            return digitsOnly.count >= 10 && digitsOnly.count <= 11
        case "+1":
            return digitsOnly.count == 10
        case "+351":
            return digitsOnly.count == 9
        default:
            return digitsOnly.count >= 8
        }
    }
    
    func nextStep() {
        guard canProceed else {
            errorMessage = getValidationErrorMessage()
            return
        }
        
        errorMessage = nil
        
        if currentStep == .contact {
            Task { await register() }
        } else if let nextStep = RegisterStep(rawValue: currentStep.rawValue + 1) {
            withAnimation {
                currentStep = nextStep
            }
        }
    }
    
    func previousStep() {
        guard let previousStep = RegisterStep(rawValue: currentStep.rawValue - 1) else {
            backToGateway()
            return
        }
        
        errorMessage = nil
        
        withAnimation {
            currentStep = previousStep
        }
    }

    
    func register() async {
        guard registerData.isValid else {
            errorMessage = "Por favor, verifique todos os campos."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            try await authState.register(data: registerData)
            onSuccess()
        } catch let error as AuthError {
            errorMessage = error.toErrorType().message
        } catch {
            errorMessage = "Erro ao criar conta. Tente novamente."
        }
        
        isLoading = false
    }
    
    func backToGateway() {
        onBackToGateway()
    }
    
    private func getValidationErrorMessage() -> String {
        switch currentStep {
        case .authentication:
            if registerData.email.isEmpty || !registerData.email.contains("@") {
                return "Por favor, insira um e-mail válido."
            }
            if !registerData.password.isValidPassword {
                return "A senha não atende aos requisitos de segurança."
            }
            if registerData.password != registerData.confirmPassword {
                return "As senhas não coincidem."
            }
            
        case .personalData:
            if registerData.name.isEmpty {
                return "Por favor, insira seu nome."
            }
            if registerData.lastName.isEmpty {
                return "Por favor, insira seu sobrenome."
            }
            
        case .contact:
            return "Por favor, insira um telefone válido."
        }
        
        return "Por favor, preencha todos os campos corretamente."
    }
}
