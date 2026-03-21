import Foundation
import SwiftUI
import Combine

@MainActor
final class WelcomeViewModel: ObservableObject, WelcomeViewModelProtocol {
    
    @Published private(set) var userName: String = ""
    @Published private(set) var greeting: String = ""
    @Published private(set) var isAuthenticated: Bool = false
    
    var onComplete: (() -> Void)?
    
    private let authState: AuthState
    private let onboardingRepository: OnboardingRepositoryProtocol
    
    init(
        authState: AuthState = .shared,
        onboardingRepository: OnboardingRepositoryProtocol
    ) {
        self.authState = authState
        self.onboardingRepository = onboardingRepository
        
        setupUserData()
    }
    
    private func setupUserData() {
        isAuthenticated = authState.isAuthenticated
        
        if let user = authState.currentUser {
            userName = user.formalGreeting
            greeting = "Sua jornada de luxo começa agora"
        } else {
            userName = "Visitante"
            greeting = "Explore nosso universo de elegância"
        }
    }
    
    // MARK: - Actions
    func completeWelcome() {
        onboardingRepository.markWelcomeAsSeen()
        onComplete?()
    }
}
