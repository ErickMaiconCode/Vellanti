import SwiftUI

final class SplashCoordinator: SplashCoordinatorProtocol {
    
    private let repository: OnboardingRepositoryProtocol
    private let onComplete: () -> Void
    
    init(
        repository: OnboardingRepositoryProtocol,
        onComplete: @escaping () -> Void
    ) {
        self.repository = repository
        self.onComplete = onComplete
    }
    
    func start() {}
    
    func splashDidFinish() {
        onComplete()
    }
    
    func makeSplashView() -> some View {
        let viewModel = SplashViewModel(
            coordinator: self,
            repository: repository
        )
        return SplashScreenView(viewModel: viewModel)
    }
    
}
