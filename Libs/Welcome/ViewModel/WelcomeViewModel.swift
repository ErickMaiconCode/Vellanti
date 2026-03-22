import Foundation
import Combine

final class WelcomeViewModel: ObservableObject, WelcomeViewModelProtocol {
    
    // MARK: - Published Properties (Protocol Conformance)
    @Published private(set) var title: String = ""
    
    // MARK: - Private Properties
    var onComplete: (() -> Void)?
    private let authState: AuthState
    private let onboardingRepository: OnboardingRepositoryProtocol

    // MARK: - Init
    init(
        authState: AuthState,
        onboardingRepository: OnboardingRepositoryProtocol
    ) {
        self.authState = authState
        self.onboardingRepository = onboardingRepository
        
        setupContent()
    }
    
    // MARK: - Logic
    private func setupContent() {
        if authState.isAuthenticated {
            // Lógica para Usuário Logado
            title = "Sua coleção particular o aguarda, \(authState.formalGreeting)"
        } else {
            // Lógica para Visitante
            title = "O verdadeiro luxo vive na sutileza.\nBem-vindo ao universo Vellanti."
        }
    }

    func completeWelcome() {
        onboardingRepository.markWelcomeAsSeen()
        onComplete?()
    }
}
