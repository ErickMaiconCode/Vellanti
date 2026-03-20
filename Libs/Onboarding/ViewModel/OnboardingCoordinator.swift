import SwiftUI


final class OnboardingCoordinator: OnboardingCoordinatorProtocol {
    
    private let permissionService: PermissionServiceProtocol
    private let repository: OnboardingRepositoryProtocol
    private let onComplete: () -> Void
    
    init(
        permissionService: PermissionServiceProtocol,
        repository: OnboardingRepositoryProtocol,
        onComplete: @escaping () -> Void
    ) {
        self.permissionService = permissionService
        self.repository = repository
        self.onComplete = onComplete
    }
    
    func start() {}
    
    func showNextPage() {}
    
    func finishOnboarding() {
        onComplete()
    }
    
    func makeOnboardingView() -> some View {
        let viewModel = OnboardingViewModel(
            coordinator: self,
            permissionService: permissionService,
            repository: repository
        )
        return OnboardingView(viewModel: viewModel)
    }
}
