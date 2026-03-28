import SwiftUI
import Combine

class AppCoordinator: ObservableObject {
    
    enum Screen {
        case loading
        case splash
        case onboarding
        case authGateway
        case welcome
        case login
        case register
        case main
    }
    
    @Published var currentScreen: Screen = .loading
    private let container = DependencyContainer.shared
    private var authCoordinator: AuthGatewayCoordinator?
    private var welcomeCoordinator: WelcomeCoordinator?
    private let initialFlowCompletedKey = "hasCompletedInitialFlow"
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.currentScreen = .splash
        }
    }
    
    func didFinishSplash() {
        let hasCompletedInitialFlow = UserDefaults.standard.bool(forKey: initialFlowCompletedKey)
        
        if AuthState.shared.isAuthenticated || hasCompletedInitialFlow {
            currentScreen = .main
        } else if container.onboardingRepository.hasCompletedOnboarding() {
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
    
    func makeLoginView() -> some View {
        LoginView(
            onSuccess: { [weak self] in
                self?.showWelcome()
            },
            onBackToGateway: { [weak self] in
                self?.currentScreen = .authGateway
            }
        )
    }
    
    func makeRegisterView() -> some View {
        RegisterView(
            onSuccess: { [weak self] in
                self?.showWelcome()
            },
            onBackToGateway: { [weak self] in
                self?.currentScreen = .authGateway
            }
        )
    }
    
    func makeWelcomeView() -> some View {
        let coordinator = container.makeWelcomeCoordinator()
        self.welcomeCoordinator = coordinator
        
        coordinator.onComplete = { [weak self] in
            UserDefaults.standard.set(true, forKey: self?.initialFlowCompletedKey ?? "hasCompletedInitialFlow")
            self?.currentScreen = .main
        }
        return coordinator.makeWelcomeView()
    }
    

    func makeMainView() -> some View {
        return TabBarContainerView()
            .environmentObject(container.cartViewModel)
            .environmentObject(container.orderViewModel)
            .environmentObject(container.wishlistViewModel)
    }
}
