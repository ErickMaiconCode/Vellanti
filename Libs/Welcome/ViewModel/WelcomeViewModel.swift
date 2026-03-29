import Foundation
import Combine

final class WelcomeViewModel: ObservableObject, WelcomeViewModelProtocol {
    
    @Published private(set) var title: String = ""
    @Published var isAnimating = false

    var onComplete: (() -> Void)?
    private let authState: AuthState
    private let onboardingRepository: OnboardingRepositoryProtocol

    init(
        authState: AuthState,
        onboardingRepository: OnboardingRepositoryProtocol
    ) {
        self.authState = authState
        self.onboardingRepository = onboardingRepository
        
        setupContent()
    }
    
    private func setupContent() {
        if authState.isAuthenticated {
            title = "Sua coleção particular o aguarda, \(authState.formalGreeting)"
        } else {
            title = "O verdadeiro luxo vive na sutileza.\nBem-vindo ao universo Vellanti."
        }
    }
    
    func completeWelcome() {
        onboardingRepository.markWelcomeAsSeen()
        onComplete?()
    }
}
