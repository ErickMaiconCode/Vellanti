import SwiftUI
import Combine

class AppCoordinator: ObservableObject {
    
    enum Screen {
        case loading
        case splash
        case onboarding
        case authGateway
        case welcome
        case home
        case login
        case register
    }
    
    @Published var currentScreen: Screen = .loading
    private let container = DependencyContainer.shared
    private var authCoordinator: AuthGatewayCoordinator?
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.currentScreen = .splash
        }
    }
    
    func showSplash() {
        currentScreen = .splash
    }
    
    func didFinishSplash() {
        if container.onboardingRepository.hasCompletedOnboarding() {
            currentScreen = .authGateway
        } else {
            currentScreen = .onboarding
        }
    }
    
    func didFinishOnboarding() {
        container.onboardingRepository.makeOnboardingAsCompleted()
        currentScreen = .authGateway
    }
    
    func showLogin() {
        currentScreen = .login
    }
    
    func showRegister() {
        currentScreen = .register
    }
    
    func showHome() {
        currentScreen = .home
    }
    
    func showWelcome() {
        currentScreen = .welcome
    }
    
    func makeSplashView() -> some View {
        let coordinator = container.makeSplashCoordinator { [weak self] in
            self?.didFinishSplash()
        }
        return coordinator.makeSplashView()
    }
    
    func makeOnboardingView() -> some View {
        let coordinator = container.makeOnboardingCoordinator { [weak self] in
            self?.didFinishOnboarding()
        }
        return coordinator.makeOnboardingView()
    }
    
    func makeAuthGatewayView() -> some View {
        let coordinator = container.makeAuthGatewayCoordinator(
            showContinueWithoutLogin: true,
            onLoginTapped: { [weak self] in self?.showLogin() },
            onRegisterTapped: { [weak self] in self?.showRegister() },
            onContinueWithoutLogin: { [weak self] in self?.showWelcome() }
        )
        self.authCoordinator = coordinator
        return coordinator.makeAuthGatewayView()
    }
    
    func makeWelcomeView() -> some View {
        let coordinator = container.makeWelcomeCoordinator()
        coordinator.onComplete = { [weak self] in
            self?.showHome()
        }
        return coordinator.makeWelcomeView()
    }
}
