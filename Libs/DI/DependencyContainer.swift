import SwiftUI

protocol ServiceFactory {
    var permissionService: PermissionServiceProtocol { get }
}

protocol RepositoryFactory {
    var onboardingRepository: OnboardingRepositoryProtocol { get }
    var cartRepository: CartRepositoryProtocol { get }
    var orderRepository: OrderRepositoryProtocol { get }
    var wishlistRepository: WishlistRepositoryProtocol { get }
    var boutiqueRepository: BoutiqueRepositoryProtocol { get }
}

protocol ViewModelFactory {
    func makeCartViewModel() -> CartViewModel
    func makeOrderViewModel() -> OrderViewModel
    func makeWishlistViewModel() -> WishlistViewModel
    func makeProductListViewModel() -> ProductListViewModel
    func makeAdminViewModel() -> AdminViewModel
}

protocol CoordinatorFactory {
    func makeSplashCoordinator(onComplete: @escaping () -> Void) -> SplashCoordinator
    func makeOnboardingCoordinator(onComplete: @escaping () -> Void) -> OnboardingCoordinator
    func makeAuthGatewayCoordinator(showContinueWithoutLogin: Bool, onLoginTapped: @escaping () -> Void, onRegisterTapped: @escaping () -> Void, onContinueWithoutLogin: @escaping () -> Void) -> AuthGatewayCoordinator
    func makeWelcomeCoordinator() -> WelcomeCoordinator
    func makeProfileCoordinator() -> ProfileCoordinator
}

final class DependencyContainer: ServiceFactory, RepositoryFactory, ViewModelFactory, CoordinatorFactory {
    
    static let shared = DependencyContainer()

    lazy var permissionService: PermissionServiceProtocol = PermissionService()
    lazy var onboardingRepository: OnboardingRepositoryProtocol = OnboardingRepository()
    lazy var cartRepository: CartRepositoryProtocol = CoreDataCartRepository()
    lazy var orderRepository: OrderRepositoryProtocol = CoreDataOrderRepository()
    lazy var wishlistRepository: WishlistRepositoryProtocol = CoreDataWishlistRepository()
    lazy var boutiqueRepository: BoutiqueRepositoryProtocol = BoutiqueRepository()

    func makeCartViewModel() -> CartViewModel {
        return CartViewModel(repository: cartRepository)
    }
    
    func makeOrderViewModel() -> OrderViewModel {
        return OrderViewModel(repository: orderRepository)
    }
    
    func makeWishlistViewModel() -> WishlistViewModel {
        return WishlistViewModel(repository: wishlistRepository)
    }

    func makeSplashCoordinator(onComplete: @escaping () -> Void) -> SplashCoordinator {
        return SplashCoordinator(repository: onboardingRepository, onComplete: onComplete)
    }
    
    func makeAdminViewModel() -> AdminViewModel {
        return AdminViewModel(repository: boutiqueRepository)
    }
    
    func makeOnboardingCoordinator(onComplete: @escaping () -> Void) -> OnboardingCoordinator {
        return OnboardingCoordinator(permissionService: permissionService, repository: onboardingRepository, onComplete: onComplete)
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
    
    func makeProductListViewModel() -> ProductListViewModel {
        return ProductListViewModel(repository: boutiqueRepository)
    }

}
