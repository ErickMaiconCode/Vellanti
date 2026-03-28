import SwiftUI

// MARK: - Dependency Container

final class DependencyContainer {
    
    static let shared = DependencyContainer()
    
    private init() {}
    
    // MARK: - Services
    
    lazy var cartViewModel = CartViewModel()
    
    lazy var orderViewModel = OrderViewModel()
    
    lazy var authState: AuthState = AuthState.shared
    
    lazy var wishlistViewModel: WishlistViewModel = WishlistViewModel()
    
    lazy var permissionService: PermissionServiceProtocol = {
        return PermissionService()
    }()
    
    lazy var onboardingRepository: OnboardingRepositoryProtocol = {
        return OnboardingRepository()
    }()
    
    // MARK: - Coordinators
    
    func makeSplashCoordinator(onComplete: @escaping () -> Void) -> SplashCoordinator {
        return SplashCoordinator(
            repository: onboardingRepository,
            onComplete: onComplete)
    }
    
    func makeOnboardingCoordinator(onComplete: @escaping () -> Void) -> OnboardingCoordinator {
        return OnboardingCoordinator(
            permissionService: permissionService,
            repository: onboardingRepository,
            onComplete: onComplete
        )
    }
    
    func makeAuthGatewayCoordinator(
        showContinueWithoutLogin: Bool = true,
        onLoginTapped: @escaping () -> Void,
        onRegisterTapped: @escaping () -> Void,
        onContinueWithoutLogin: @escaping () -> Void
    ) -> AuthGatewayCoordinator {
        let coordinator = AuthGatewayCoordinator(showContinueWithoutLogin: showContinueWithoutLogin)
        coordinator.onLoginTapped = onLoginTapped
        coordinator.onRegisterTapped = onRegisterTapped
        coordinator.onContinueWithoutLogin = onContinueWithoutLogin
        return coordinator
    }
    
    func makeWelcomeCoordinator() -> WelcomeCoordinator {
        return WelcomeCoordinator()
    }
    
    func makeProfileCoordinator() -> ProfileCoordinator {
        return ProfileCoordinator()
    }
    
    func makeProfileView(coordinator: ProfileCoordinator) -> some View {
        return ProfileListView(coordinator: coordinator)
            .environmentObject(authState)
    }
}
