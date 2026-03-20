// MARK: - Dependency Container

final class DependencyContainer {
    
    static let shared = DependencyContainer()
    
    private init() {}
    
    // MARK: - Services
    
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
}
